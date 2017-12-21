require './config/environment'
require 'rack-flash'

class TaskController < ApplicationController
  use Rack::Flash

  get '/tasks/new' do
    if logged_in?
      erb :'tasks/create_tasks'
    else
      redirect '/login'
    end
  end

  post '/tasks' do
    unless params[:name].empty?
      @task = Tweet.create(:name => params[:name])
      @task.user_id = current_user.id
      @task.save
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Your task must contain text."
      redirect "/tasks/new"
    end
  end
end
