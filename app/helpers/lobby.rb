def find_open_games
  Game.where(challenger_id: nil)
end