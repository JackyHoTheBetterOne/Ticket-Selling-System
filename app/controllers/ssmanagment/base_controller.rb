class Ssmanagment::BaseController < ApplicationController
  # layout 'app/editor'
  before_action :authenticate_admin!
end
