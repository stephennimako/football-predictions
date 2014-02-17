class PredictionsController < ApplicationController

  require 'json'

  before_filter :authenticate_user!

  helper_method :bonus_fixture

  def new
    @selected_teams = ['West Ham', 'Chelsea', 'Arsenal', 'Man City', 'Man Utd', 'Liverpool', 'Spurs']

    not_started_predictions = Prediction.where(:prediction_status_id => 0)
    if not_started_predictions.length > 0
      @fixtures = generate_fixtures_from_predictions not_started_predictions
    else
      fixture_service = FixtureService.new
      @fixtures = fixture_service.retrieve_future_fixtures
      @fixtures = @fixtures.select do |fixture|
        @selected_teams.include?(fixture[:home_team]) || @selected_teams.include?(fixture[:away_team])
      end
    end

    #Prediction.delete_all

    #@fixtures = [{:kick_off => 'Sunday 19 October 2013 16:00:00', :home_team => 'West Ham', :away_team => 'Man City'},
    #             {:kick_off => 'Sunday 19 October 2013 16:00:00', :home_team => 'Arsenal', :away_team => 'Liverpool'}
    #]
    append_data_to_fixtures

    #populate_players

    @predictions = Prediction.where("kick_off > ?", Date.today - 3.days).includes(:user, :prediction_status)
    evaluate_predictions @predictions

    @display_name = current_user.name
    @standings = calculate_standings
  end

  def create
    if request.xhr?
      predictions_json = JSON.parse request.body.read

      predictions_json.each do |prediction|
        @count = 0
        if prediction["additional_goal_scorer"] == ''
          @count = Prediction.where(:home_team => prediction["home_team"], :away_team => prediction["away_team"]).where.not(:user_id => current_user.id).where("home_team_score = ? AND away_team_score = ? AND goal_scorer = ?", prediction["home_team_score"], prediction["away_team_score"], prediction["goal_scorer"]).count
        else
          @count = Prediction.where(:home_team => prediction["home_team"], :away_team => prediction["away_team"]).where.not(:user_id => current_user.id).where("home_team_score = ? AND away_team_score = ? AND goal_scorer = ? AND additional_goal_scorer = ?", prediction["home_team_score"], prediction["away_team_score"], prediction["goal_scorer"], prediction["additional_goal_scorer"]).count
        end
        prediction[:valid] = @count == 0 ? true : false
      end

      render :layout => false, :json => predictions_json
    else
      prediction_params.each do |params|
        if !params[:id].blank?
          Prediction.find(params[:id]).update(params)
        else
          Prediction.create(params)
        end
      end
      prediction_made_email
      redirect_to '/'
    end
  end

  def bonus_fixture home_team, away_team
    @selected_teams.include?(home_team) && @selected_teams.include?(away_team)
  end

  private

  def calculate_standings
    standings = []
    users_sorted_by_precedence.each_with_index do |user, index|
      partial_predictions = Prediction.where(:prediction_status_id => [1, 2], :user_id => user.id).count
      correct_predictions = Prediction.where(:prediction_status_id => 3, :user_id => user.id).count
      correct_bonus_predictions = Prediction.where(:prediction_status_id => 5, :user_id => user.id).count
      partial_bonus_predictions = Prediction.where(:prediction_status_id => [6, 7], :user_id => user.id).count
      points = partial_predictions + (correct_predictions * 3) + (partial_bonus_predictions * 3) + (correct_bonus_predictions * 5)
      points = points + 5 if user.id == 5
      points = points + 7 if user.id == 4
      points = points + 8 if user.id == 3
      standings << {:user => user.name, :points => points, :precedence => index + 1}
    end
    standings.sort! { |x, y| x[:points] <=> y[:points] }.reverse!
  end

  def prediction_params
    count = 0
    prediction_params = []

    while params[:prediction].key? "home_team_#{count}"
      prediction_params << {:home_team => params[:prediction]["home_team_#{count}"],
                            :away_team => params[:prediction]["away_team_#{count}"],
                            :home_team_score => params[:prediction]["home_team_score_#{count}"].to_i,
                            :away_team_score => params[:prediction]["away_team_score_#{count}"].to_i,
                            :goal_scorer => params[:prediction]["goal_scorer_#{count}"],
                            :additional_goal_scorer => params[:prediction]["additional_goal_scorer_#{count}"],
                            :kick_off => DateTime.parse(params[:prediction]["kick_off_#{count}"]),
                            :id => params[:prediction]["prediction_id_#{count}"],
                            :user_id => current_user.id,
                            :prediction_status_id => 0}
      count = count + 1
    end
    prediction_params
  end

  def evaluate_predictions predictions
    result_available_after = 2
    unchecked_predictions = predictions.where("kick_off < ? AND prediction_status_id = 0", Time.now - result_available_after.hours).order("kick_off ASC")

    if unchecked_predictions.length > 0
      updated_results = false
      results = ResultService.new.retrieve_results unchecked_predictions.last.kick_off

      unchecked_predictions.each do |prediction|
        results_key = (prediction.home_team + " v " + prediction.away_team).gsub!(" ", "_").to_sym
        result = results[results_key]
        if !result.nil?
          correct_scoreline = prediction.home_team_score == result[:home_team_score] && prediction.away_team_score == result[:away_team_score]

          if bonus_fixture prediction.home_team, prediction.away_team
            correct_scorer = result[:home_goal_scorers].include?(prediction.goal_scorer) || (result[:home_goal_scorers].empty? && prediction.goal_scorer == 'no scorer')
            correct_additional_scorer = result[:away_goal_scorers].include?(prediction.additional_goal_scorer) || (result[:away_goal_scorers].empty? && prediction.additional_goal_scorer == 'no scorer')
            prediction.update(calculate_bonus_points(correct_scoreline, correct_scorer, correct_additional_scorer))
          else
            goal_scorers = result[:home_goal_scorers] + result[:away_goal_scorers]
            correct_scorer = goal_scorers.include?(prediction.goal_scorer) || (goal_scorers.empty? && prediction.goal_scorer == 'no scorer')
            prediction.update(calculate_points(correct_scoreline, correct_scorer))
          end
          updated_results = true
        end
      end
      update_user_precedence if Prediction.where(:prediction_status_id => 0).count == 0 && updated_results
      results_updated_email if updated_results
    end
  end

  def calculate_points correct_scoreline, correct_scorer
    if correct_scoreline && correct_scorer
      points = 3
      status = 3
    else
      if correct_scoreline
        points = 1
        status = 2
      else
        if correct_scorer
          points = 1
          status = 1
        else
          points = 0
          status = 4
        end
      end
    end
    {:points => points, :prediction_status_id => status}
  end

  def calculate_bonus_points correct_scoreline, correct_scorer, correct_additional_scorer
    if correct_scoreline && correct_scorer && correct_additional_scorer
      points = 5
      status = 5
    elsif correct_scoreline && (correct_scorer || correct_additional_scorer)
      points = 3
      status = 6
    elsif correct_scorer && correct_additional_scorer
      points = 3
      status = 7
    elsif correct_scoreline
      points = 1
      status = 2
    elsif correct_scorer
      points = 1
      status = 1
    else
      points = 0
      status = 4
    end
    {:points => points, :prediction_status_id => status}
  end

  def generate_fixtures_from_predictions predictions
    fixtures = []
    predictions.each do |prediction|
      fixture = {:kick_off => prediction.kick_off, :home_team => prediction.home_team, :away_team => prediction.away_team}
      fixtures << fixture unless fixtures.include? fixture
    end
    fixtures
  end

  def users_sorted_by_precedence
    user_precedences = UserPrecedence.order(:predicted_first, :precedence)
    users = []
    user_precedences.each do |user_precedence|
      users << user_precedence.user
    end
    users
  end

  def update_user_precedence
    user_precedences = UserPrecedence.order(:predicted_first, :precedence)
    if user_precedences.last.updated_at < DateTime.now - 1.days
      user_precedences[0].update(:predicted_first => user_precedences[0].predicted_first + 1)
    end
  end

  def prediction_made_email
    predictor = User.where(:id => current_user.id)[0]
    sorted_users = users_sorted_by_precedence
    UserMailer.prediction_made(sorted_users, predictor, sorted_users).deliver
  end

  def results_updated_email
    UserMailer.results_updated(User.all, calculate_standings).deliver
  end

  def populate_players
    players = PlayerService.new.retrieve_players
    Player.create(players)
  end

  def append_data_to_fixtures
    @fixtures.each do |fixture|
      append_predictions_to_fixtures fixture
      append_players_to_fixtures fixture
    end
  end

  def append_predictions_to_fixtures fixture
    prediction = Prediction.find_by(:home_team => fixture[:home_team],
                                    :away_team => fixture[:away_team],
                                    :user_id => current_user.id)

    unless prediction.nil?
      fixture.merge! :home_team_score => prediction.home_team_score,
                     :away_team_score => prediction.away_team_score,
                     :prediction_id => prediction.id
    end

    fixture[:goal_scorer] = prediction.nil? ? 'no scorer' : prediction.goal_scorer
    fixture[:additional_goal_scorer] = prediction.nil? ? 'no scorer' : prediction.additional_goal_scorer
  end

  def append_players_to_fixtures fixture
    if bonus_fixture fixture[:home_team], fixture[:away_team]
      fixture[:players] =  goal_scorers_for_team(fixture[:home_team])
      fixture[:additional_players] =  goal_scorers_for_team(fixture[:away_team])
    else
      fixture[:players] =  goal_scorers_for_team([fixture[:home_team], fixture[:away_team]])
    end
  end

  def goal_scorers_for_team(teams)
    players = ['no scorer']
    Player.all.where(:team => teams).each do |player|
      players << player.name
    end
    players
  end
end
