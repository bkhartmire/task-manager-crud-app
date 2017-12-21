require './config/environment'
require 'rack-flash'

class TaskController < ApplicationController
  use Rack::Flash
end
