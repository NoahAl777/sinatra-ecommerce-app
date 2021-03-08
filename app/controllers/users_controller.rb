class UsersController < ApplicationController

  get '/login' do
    erb :login
  end

  # receive the login form,
  # find the user, and log the user in (create session)
  post '/login' do
     # Find the user
     @user = User.find_by(email: params[:email])
     # Authenticate the user
     if @user.authenticate(params[:password])
     # log the user in - create user session
     session[:user_id] = @user.id #actually logging the user in
     # redirect the user's landing page
     puts session
     redirect "users/#{@user.id}"
     else
      # tell the user they entered invalid credentials
      # redirect them to the login page
      redirect '/login'
     end
  end

  get '/signup' do # render the signup form
    erb :signup
  end

  post '/users' do
    # create new user and
    # persist to database
    # params will look like this: {"name"=>"Noah", "email"=>"n@email.com", "password"=>"password"}
    # make sure input is valid
    if params[:name] != "" && params[:email] != "" && params[:password] != "" # do all three have values?
      @user = User.create(params) # if yes create a new user
      session[:user_id] = @user.id # actually logging the user in
      redirect "/users/#{@user.id}" # url
    else # not valid input
      redirect '/signup'
    end
  end

  # user SHOW route
  get '/users/:id' do
    @user = User.find_by(id: params[:id]) # retrieves user from databases
    erb :'/users/show' # view displayed, erbs should only come from get request with exception of receiving invalid data on a post request
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end