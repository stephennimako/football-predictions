class UpdatePredictionStatusWithValues < ActiveRecord::Migration
  def up
    status_hash = [{:id => 0, :status => 'Match Not Complete'},
                   {:id => 1, :status => 'Correct Scorer'},
                   {:id => 2, :status => 'Correct Scoreline'},
                   {:id => 3, :status => 'Correct Prediction'},
                   {:id => 4, :status => 'Incorrect Prediction'}]
    PredictionStatus.create(status_hash)
  end

  def down
    PredictionStatus.delete_all
  end
end
