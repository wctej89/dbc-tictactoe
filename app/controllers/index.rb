enable :session

get '/' do
  @games = find_open_games
  erb :index
end

get '/games/new' do
  game = Game.create
  current_user.games << game
  redirect "/games/#{game.id}"
end

get '/games/:id' do
  @game = Game.find(params[:id])
  erb :game_room
end

get '/games/:id/opponent' do
  @game = Game.find(params[:id])
  @opponent = User.find(@game.challenger_id) if @game.challenger_id
  @opponent ? @opponent.name : "nil"
end

get '/games/:id/turn' do
  @game = Game.find(params[:id])
  @game.current_board = # stuff from things

  if current_user.id == @game.challenger_id
    if @game.user_turn
      "false"
    else
      @game.user_turn = !@game.user_turn
      @game.save 
      "O"
    end
  else
    if @game.user_turn
      @game.user_turn = !@game.user_turn
      @game.save
      "X"
    else
      "false"
    end
  end
end

post '/games' do
  game = Game.find(params[:id])
  if game.user_id != current_user.id
    game.challenger_id = current_user.id 
  else
    return "Stop being dumb"
  end
  game.save
  redirect "/games/#{params[:id]}"
end

put '/games/:id/board' do
  game = Game.find(params[:id])
  game.update_attribute(:current_board, params[:current_board])
end

get '/games/:id/board' do
  Game.find(params[:id]).current_board
end





#----------- SESSIONS -----------

get '/sessions/new' do
  erb :sign_in
end

post '/sessions' do
  @user = User.find_by_email(params[:email])

  if @user && @user.password == params[:password_hash] 
    session[:user] = @user.id
    redirect '/'
  else
    @error = "Sign in failed. Is caps lock on?"
    erb :sign_in
  end
end

delete '/sessions/:id' do
  session.clear
  200
end

#----------- USERS -----------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  @user = User.new(params[:user])
  @user.password = params[:password]
  if @user.save
    erb :sign_in
  else
    @error = @user.errors
    @error.each {|x| puts x}
    erb :sign_up
  end
end