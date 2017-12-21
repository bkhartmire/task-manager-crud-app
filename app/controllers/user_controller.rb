require './config/environment'

class UserController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect "/tweets"
    else
      erb :'users/create_user'
    end
  end


end
