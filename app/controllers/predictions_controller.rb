class PredictionsController < ApplicationController

  require 'json'

  before_filter :authenticate_user!

  def new
    @selected_teams = ['West Ham', 'Chelsea', 'Arsenal', 'Man City', 'Man Utd', 'Liverpool', 'Tottenham']
    if Rails.env == "production"
      fixture_service = FixtureService.new
      @fixtures = fixture_service.retrieve_future_fixtures
    else
      @fixtures = [{:kick_off=>"Saturday 14 September 2013 12:45:00", :home_team=>"Man Utd", :away_team=>"Crystal Palace"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Aston Villa", :away_team=>"Newcastle"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Fulham", :away_team=>"West Brom"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Hull", :away_team=>"Cardiff"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Tottenham", :away_team=>"Norwich"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Stoke", :away_team=>"Man City"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Sunderland", :away_team=>"Arsenal"}, {:kick_off=>"Saturday 14 September 2013 17:30:00", :home_team=>"Everton", :away_team=>"Chelsea"}, {:kick_off=>"Sunday 15 September 2013 16:00:00", :home_team=>"Southampton", :away_team=>"West Ham"}, {:kick_off=>"Monday 16 September 2013 20:00:00", :home_team=>"Swansea", :away_team=>"Liverpool"}]
    end
    @fixtures = @fixtures.select do |fixture|
      @selected_teams.include?(fixture[:home_team]) || @selected_teams.include?(fixture[:away_team])
    end
    append_data_to_fixtures

    #populate_players

    @predictions = Prediction.includes(:user, :prediction_status)
    evaluate_predictions if Rails.env == "production"

    @display_name = current_user.email
    calculate_standings
  end

  def create
    if request.xhr?
      predictions_json = JSON.parse request.body.read
      predictions_json.each do |prediction|
        count = Prediction.where(:home_team => prediction["home_team"], :away_team => prediction["away_team"]).where.not(:user_id => current_user.id).where("home_team_score = ? AND away_team_score = ? OR goal_scorer = ?", prediction["home_team_score"], prediction["away_team_score"], prediction["goal_scorer"]).count
        prediction[:valid] = count == 0 ? true : false
      end

      render :layout => false, :json=>predictions_json
    else
      prediction_params.each do |params|
        if !params[:id].blank?
          Prediction.find(params[:id]).update(params)
        else
          Prediction.create(params)
        end
      end
      redirect_to '/'
    end
  end

  private

  def calculate_standings
    @standings = []
    User.all.each do |user|
      partial_predictions = Prediction.where(:prediction_status_id => [1, 2], :user_id => user.id).count
      correct_predictions = Prediction.where(:prediction_status_id => 3, :user_id => user.id).count
      points = partial_predictions + (correct_predictions * 3)
      if [3,4,5].include? user.id
        points = points + 8
      end
      @standings << {:player => user.email, :points => points}
    end
    @standings.sort! { |x, y| x[:points] <=> y[:points] }.reverse!
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
                            :kick_off => DateTime.parse(params[:prediction]["kick_off_#{count}"]),
                            :id => params[:prediction]["prediction_id_#{count}"],
                            :user_id => current_user.id,
                            :prediction_status_id => 0}
      count = count + 1
    end
    prediction_params
  end

  def evaluate_predictions
    result_available_after = 2
    unchecked_predictions = @predictions.where("kick_off < ? AND prediction_status_id = 0", Time.now + result_available_after.hours)
    .order("kick_off ASC")

    if unchecked_predictions.length > 0

      results = ResultService.new.retrieve_results unchecked_predictions.last.kick_off

      unchecked_predictions.each do |prediction|
        results_key = (prediction.home_team + " v " + prediction.away_team).gsub!(" ", "_").to_sym
        result = results[results_key]
        if !result.nil?
          correct_scoreline = prediction.home_team_score == result[:home_team_score] && prediction.away_team_score == result[:away_team_score]
          correct_scorer = result[:goal_scorers].include?(prediction.goal_scorer) || (result[:goal_scorers].empty? && prediction.goal_scorer == 'no scorer')

          prediction.update(calculate_points correct_scoreline, correct_scorer)
        end
      end
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
  end

  def append_players_to_fixtures fixture
    players = fixture[:players] = ['no scorer']
    Player.all.where(:team => [ fixture[:home_team], fixture[:away_team] ]).each do |player|
      players << player.name
    end
  end
end
