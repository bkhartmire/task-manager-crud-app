require './config/environment'
require 'rack-flash'

class TaskController < ApplicationController
  use Rack::Flash

  get '/tweets/new' do
    if logged_in?
      erb :'tasks/create_tasks'
    else
      redirect '/login'
    end
  end
end
