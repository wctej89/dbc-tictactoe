class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :user
      t.integer :challenger_id
      t.integer :winner_id
      t.boolean :user_turn, default: true
      t.text :current_board, default: <<-DOC 
<div class='board'>
  <div class='row'>
    <div id='square0' class='square'></div>
    <div id='square1' class='square'></div>
    <div id='square2' class='square'></div>
  </div>

  <div class='row'>
    <div id='square3' class='square'></div>
    <div id='square4' class='square'></div>
    <div id='square5' class='square'></div>
  </div>

  <div class='row'>
    <div id='square6' class='square'></div>
    <div id='square7' class='square'></div>
    <div id='square8' class='square'></div>
  </div>
</div>
DOC
    end
  end
end
