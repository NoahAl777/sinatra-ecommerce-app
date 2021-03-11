class EcommerceEntriesController < ApplicationController
  
  get '/ecommerce_entries' do
    @ecommerce_entries = EcommerceEntry.all
    erb :'ecommerce_entries/index' 
  end
  # get ecommerce_entries/new to render a form to create a new entry
  get '/ecommerce_entries/new' do
    redirect_if_not_logged_in
    erb :'/ecommerce_entries/new'
  end
  # post ecommerce_entries to create a new ecommerce entry
  post '/ecommerce_entries' do
    redirect_if_not_logged_in
    # create and save to database
    # only create entry if user is logged in
    # only save entry if it has content
    if params[:content] != ""
      flash[:message] = "Post was succesfully created."
      # create a new entry
      @ecommerce_entry = EcommerceEntry.create(title: params[:title], price: params[:price], content: params[:content], user_id: current_user.id)
      redirect "/ecommerce_entries/#{@ecommerce_entry.id}"
    else
      flash[:message] = "Something went wrong. Posts can't be empty."
      redirect '/ecommerce_entries/new'
    end
  end

  # show page for ecommerce entry
  get '/ecommerce_entries/:id' do
    redirect_if_not_logged_in
    set_ecommerce_entry
    erb :"ecommerce_entries/show"
  end

  # This route should send us to eccomerce_entries/edit.erb
  # render an edit form
  get '/ecommerce_entries/:id/edit' do
    # find entry to edit
    set_ecommerce_entry
    # only logged in users can edit posts
    redirect_if_not_logged_in
    # verify current user is the same as original entry user
      if authorized_to_edit?(@ecommerce_entry)
        erb :'/ecommerce_entries/edit'
      else
        redirect "users/#{current_user.id}"
      end
  end
 
  patch '/ecommerce_entries/:id' do
    # 1. find ecommerce entry
    set_ecommerce_entry
    redirect_if_not_logged_in
      # verify current user is the same as original entry user
      if @ecommerce_entry.user == current_user && params[:content] != ""
        # 2. update entry
        @ecommerce_entry.update(title: params[:title], price: params[:price], content: params[:content])
        # 3. redirect to show page
        redirect "ecommerce_entries/#{@ecommerce_entry.id}"
      else
        redirect "users/#{current_user.id}"
      end
  end

  delete '/ecommerce_entries/:id' do
    set_ecommerce_entry
    if authorized_to_edit?(@ecommerce_entry)
      # delete the entry
      @ecommerce_entry.destroy
      flash[:message] = "Succesfully deleted post."
      # redirect
      redirect '/ecommerce_entries'
    else
      # go somewhere else --not deleted
      redirect '/ecommerce_entries'
    end
  end
  # index route for all ecommerce entries

  private

  def set_ecommerce_entry
    @ecommerce_entry = EcommerceEntry.find(params[:id])
  end
end