class Ssmanagement::BaseController < ApplicationController
  layout 'ssmanagement/event_admin'

  before_action :authenticate_ssmanagement_admin!
end
