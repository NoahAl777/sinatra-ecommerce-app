require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  helpers do
    
    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user # double negate creates a boolean value thats truthy
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) #returns nil if values dont match
      # storing in instance variable avoids re querying database
    end

  end
end
