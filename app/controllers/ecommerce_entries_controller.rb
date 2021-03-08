class EcommerceEntriesController < ApplicationController
  
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
    @ecommerce_entry = EcommerceEntry.find(params[:id])
    erb :"ecommerce_entries/show"
  end

  # This route should send us to eccomerce_entries/edit.erb
  # render an edit form
  get '/ecommerce_entries/:id/edit' do
    erb :'/ecommerce_entries/edit'
  end
  # index route for all ecommerce entries
end