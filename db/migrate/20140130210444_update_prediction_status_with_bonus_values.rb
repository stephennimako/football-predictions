class UpdatePredictionStatusWithBonusValues < ActiveRecord::Migration
  def up
      status_hash = [{:id => 5, :status => 'Correct Bonus Prediction'},
                     {:id => 6, :status => 'Correct Scoreline + 1 Scorer'},
                     {:id => 7, :status => 'Both Scorers Correct'}]
      PredictionStatus.create(status_hash)
    end

    def down
      PredictionStatus.delete([5,6,7])
    end
end
