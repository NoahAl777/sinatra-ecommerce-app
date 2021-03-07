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
     end
  end

  get '/signup' do

  end

  # user SHOW route
  get '/users/:id' do
    "this will be the user show route"
  end
end