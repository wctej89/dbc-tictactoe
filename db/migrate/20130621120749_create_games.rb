class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :user
      t.integer :challenger_id
      t.integer :winner_id
      t.string :current_board
      t.boolean :user_turn, default: true
    end
  end
end
