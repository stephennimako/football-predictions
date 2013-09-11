class CreatePredictionStatuses < ActiveRecord::Migration
  def change
    create_table :prediction_statuses do |t|
      t.string :status

      t.timestamps
    end
  end
end
