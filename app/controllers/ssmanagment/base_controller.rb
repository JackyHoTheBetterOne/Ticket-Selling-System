class Ssmanagment::BaseController < ApplicationController
  layout 'ssmanagment/event_admin'

  before_action :authenticate_ssmanagment_admin!
end
