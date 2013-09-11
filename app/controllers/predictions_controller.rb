class PredictionsController < ApplicationController

  before_filter :authenticate_user!

  def new
    #fixture_service = FixtureService.new
    #@fixtures = fixture_service.retrieve_future_fixtures
    @fixtures = [{:kick_off=>"Saturday 14 September 2013 12:45:00", :home_team=>"Man Utd", :away_team=>"Crystal Palace"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Aston Villa", :away_team=>"Newcastle"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Fulham", :away_team=>"West Brom"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Hull", :away_team=>"Cardiff"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Tottenham", :away_team=>"Norwich"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Stoke", :away_team=>"Man City"}, {:kick_off=>"Saturday 14 September 2013 15:00:00", :home_team=>"Sunderland", :away_team=>"Arsenal"}, {:kick_off=>"Saturday 14 September 2013 17:30:00", :home_team=>"Everton", :away_team=>"Chelsea"}, {:kick_off=>"Sunday 15 September 2013 16:00:00", :home_team=>"Southampton", :away_team=>"West Ham"}, {:kick_off=>"Monday 16 September 2013 20:00:00", :home_team=>"Swansea", :away_team=>"Liverpool"}]
    append_data_to_fixtures

    #Player.delete_all
    #populate_players

    #Prediction.delete_all
    #create_predictions
    @predictions = Prediction.includes(:user, :prediction_status)
    evaluate_predictions

    @display_name = current_user.email

    calculate_standings

    #puts '*****************************************'
    #puts @predictions
  end

  def create
    prediction_params.each do |params|
      if !params[:id].blank?
        Prediction.find(params[:id]).update(params)
      else
        Prediction.create(params)
      end
    end
    redirect_to '/'
  end

  private

  def create_predictions

    Prediction.create([{:home_team => 'Arsenal', :away_team => 'Tottenham', :home_team_score => 0,
                        :away_team_score => 0, :goal_scorer => 'no scorer', :kick_off => "2013-09-01 16:00:00.000000",
                        :user_id => 1, :prediction_status_id => 0},
                       {:home_team => 'Liverpool', :away_team => 'Man Utd', :home_team_score => 2,
                        :away_team_score => 2, :goal_scorer => 'Daniel Sturridge', :kick_off => "2013-09-01 13:30:00.000000",
                        :user_id => 1, :prediction_status_id => 0},
                       {:home_team => 'Arsenal', :away_team => 'Tottenham', :home_team_score => 1,
                        :away_team_score => 0, :goal_scorer => 'Daniel Sturridge', :kick_off => "2013-09-01 16:00:00.000000",
                        :user_id => 2, :prediction_status_id => 0},
                       {:home_team => 'Liverpool', :away_team => 'Man Utd', :home_team_score => 1,
                        :away_team_score => 0, :goal_scorer => 'Daniel Sturridge', :kick_off => "2013-09-01 13:30:00.000000",
                        :user_id => 2, :prediction_status_id => 0}

                      ])


  end

  def calculate_standings
    @standings = []
    User.all.each do |user|
      partial_predictions = Prediction.where(:prediction_status_id => [1, 2], :user_id => user.id).count
      correct_predictions = Prediction.where(:prediction_status_id => 3, :user_id => user.id).count
      points = partial_predictions + (correct_predictions * 3)
      @standings << {:player => user.email, :points => points}
    end
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
    #puts '****************************************************************'
    result_available_after = 3
    unchecked_predictions = @predictions.where("kick_off < ? AND prediction_status_id = 0", Time.now + result_available_after.hours)
    .order("kick_off ASC")

    if unchecked_predictions.length > 0
      #puts "oldest prediction kick off #{unchecked_predictions.last.kick_off}"
      #puts "number of predictions #{unchecked_predictions.length}"

      #results = ResultService.new.retrieve_results unchecked_predictions.last.kick_off

      results =
          {:Arsenal_v_Tottenham => {:home_team_score => 1, :away_team_score => 0, :goal_scorers => ["Olivier Giroud"]},
           :Liverpool_v_Man_Utd => {:home_team_score => 1, :away_team_score => 0, :goal_scorers => ["Daniel Sturridge"]},
           :West_Brom_v_Swansea => {:home_team_score => 0, :away_team_score => 2, :goal_scorers => ["Ben Davies", "Pablo Hernandez"]}
          }

      unchecked_predictions.each do |prediction|
        results_key = (prediction.home_team + " v " + prediction.away_team).gsub!(" ", "_").to_sym
        result = results[results_key]
        if !result.nil?
          #puts "****************************"
          #puts "predicted home score #{prediction.home_team_score}"
          #puts "actual home score #{result[:home_team_score]}"
          #puts "predicted away score #{prediction.away_team_score}"
          #puts "actual away score #{result[:away_team_score]}"
          #puts "predicted scorer #{prediction.goal_scorer}"
          #puts "actual scorer #{result[:goal_scorers]}"

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
