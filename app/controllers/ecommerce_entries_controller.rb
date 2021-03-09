class EcommerceEntriesController < ApplicationController
  
  get '/ecommerce_entries' do
    @ecommerce_entries = EcommerceEntry.all
    erb :'ecommerce_entries/index' 
  end
  # get ecommerce_entries/new to render a form to create a new entry
  get '/ecommerce_entries/new' do
    erb :'/ecommerce_entries/new'
  end
  # post ecommerce_entries to create a new ecommerce entry
  post '/ecommerce_entries' do
    # create and save to database
    # only create entry if user is logged in
    if !logged_in?
      redirect '/'
    end
    # only save entry if it has content
    if params[:content] != ""
      # create a new entry
      @ecommerce_entry = EcommerceEntry.create(content: params[:content], user_id: current_user.id)
      redirect "/ecommerce_entries/#{@ecommerce_entry.id}"
    else
      redirect '/ecommerce_entries/new'
    end
  end

  # show page for ecommerce entry
  get '/ecommerce_entries/:id' do
    set_ecommerce_entry
    erb :"ecommerce_entries/show"
  end

  # This route should send us to eccomerce_entries/edit.erb
  # render an edit form
  get '/ecommerce_entries/:id/edit' do
    # find entry to edit
    set_ecommerce_entry
    # only logged in users can edit posts
    if logged_in?
    # verify current user is the same as original entry user
      if authorized_to_edit?(@ecommerce_entry)
        erb :'/ecommerce_entries/edit'
      else
        redirect "users/#{current_user.id}"
      end
      else
        # send them to homepage if not logged in
        redirect "/"
    end
  end
 
  patch '/ecommerce_entries/:id' do
    # 1. find ecommerce entry
    set_ecommerce_entry
    if logged_in?
      # verify current user is the same as original entry user
      if @ecommerce_entry.user == current_user
        # 2. update entry
        @ecommerce_entry.update(content: params[:content])
        # 3. redirect to show page
        redirect "ecommerce_entries/#{@ecommerce_entry.id}"
      else
        redirect "users/#{current_user.id}"
      end
      else
        # send them to homepage if not logged in
        redirect "/"
    end
  end
  # index route for all ecommerce entries

  private

  def set_ecommerce_entry
    @ecommerce_entry = EcommerceEntry.find(params[:id])
  end
end