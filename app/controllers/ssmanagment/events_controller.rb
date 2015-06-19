class Ssmanagment::EventsController < Ssmanagment::BaseController
  respond_to :json, only: []


  def new
  end

  def create
    @event = Event.create event_params
  end

  def something
    console.log("here")
  end

  def copy
  end

  def index
    @events = Event.all
    # byebug
    # @events = Events.all
    # render some html and send it back
    # render json: @json_data, :status => 200
  end

  def show
  end

  def update
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end

end
