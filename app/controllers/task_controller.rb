require './config/environment'
require 'rack-flash'

class TaskController < ApplicationController
  use Rack::Flash

  get '/tasks/new' do
    if logged_in?
      erb :'tasks/create_task'
    else
      redirect '/login'
    end
  end

  post '/tasks' do
    unless params[:name].empty? || (params[:urgent].empty? && params[:less_urgent].empty? && params[:unurgent].empty?)
      @task = Task.create(:name => params[:name])
      @task.user_id = current_user.id
      if !params[:urgent].empty?
        @task.urgency = "urgent"
      elsif !params[:less_urgent].empty?
        @task.urgency = "less urgent"
      else !params[:unurgent].empty?
        @task.urgency = "unurgent"
      end
      @task.save
      redirect "/users/#{current_user.slug}"
    else
      flash[:message] = "Your task must contain text and urgency level."
      redirect "/tasks/new"
    end
  end

  get '/tasks/:id/edit' do
    @task = Task.find_by_id(params[:id])
    if logged_in?
      erb :'tasks/edit_task'
    else
      redirect '/login'
    end
  end

  patch '/tasks/:id' do
    @task = Task.find_by_id(params[:id])
    unless params[:name].empty?
      @task.name = params[:name]
      @task.save
      flash[:message] = "Successfully edited task"
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Please fill out all required fields"
      redirect "/tasks/#{@task.id}/edit"
    end
  end

  delete '/tasks/:id/delete' do
    @task = Task.find_by_id(params[:id])
    if logged_in? && @task.user_id == current_user
      @task.delete
      flash[:message] = "Great job!! You're a rockstar!"
      redirect "/users/#{@user.slug}"
    else
      redirect '/login'
    end
  end
end
