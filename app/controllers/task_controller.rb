require './config/environment'
require 'rack-flash'

class TaskController < ApplicationController
  use Rake::Flash
end
