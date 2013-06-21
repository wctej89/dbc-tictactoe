enable :session

get '/' do
  erb :index
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