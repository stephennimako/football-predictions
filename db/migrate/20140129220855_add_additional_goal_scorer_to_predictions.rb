class AddAdditionalGoalScorerToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :additional_goal_scorer, :string
  end
end
