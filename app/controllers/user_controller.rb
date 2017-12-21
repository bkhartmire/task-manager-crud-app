require './config/environment'
require 'rack-flash'

class UserController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if logged_in?
      redirect "/users/#{current_user.slug}"
    else
      erb :'users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect "/signup"
    else
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome to Task Manager!"
      redirect "/users/#{@user.slug}"
    end
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/login' do
    if logged_in?
      redirect "/users/#{current_user/slug}"
    else
      erb :'users/login'
    end

  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      flash[:message] = "Incorrect login information. Please try again."
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect '/'
    end
  end

end
