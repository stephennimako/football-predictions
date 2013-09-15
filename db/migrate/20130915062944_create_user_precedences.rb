class CreateUserPrecedences < ActiveRecord::Migration
  def change
    create_table :user_precedences do |t|
      t.belongs_to :user
      t.integer :precedence
      t.integer :predicted_first

      t.timestamps
    end
  end
end
