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