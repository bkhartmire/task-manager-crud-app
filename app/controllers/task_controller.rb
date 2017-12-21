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
    unless params[:content].empty?
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = current_user.id
      @tweet.save
      erb :"tweets/show_tweet"
    else
      redirect "/tweets/new"
    end
  end
end
