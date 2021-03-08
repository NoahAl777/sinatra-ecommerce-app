class EcommerceEntriesController < ApplicationController
  
  # get ecommerce_entries/new to render a form to create a new entry
  get '/ecommerce_entries/new' do
    erb :'/ecommerce_entries/new'
  end
  # post ecommerce_entries to create a new ecommerce entry
  post '/ecommerce_entries' do
  end
  # show page for ecommerce entry

  # index route for all ecommerce entries
end