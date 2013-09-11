class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|

      t.belongs_to :user
      t.belongs_to :prediction_status
      t.datetime :kick_off
      t.string :home_team
      t.string :away_team
      t.integer :home_team_score
      t.integer :away_team_score
      t.string :goal_scorer
      t.integer :points
      t.timestamps
    end
  end
end
