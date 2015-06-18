class Ssmanagment::EventsController < Ssmanagment::BaseController
  respond_to :json, only: []

  def create
    @event = Event.create event_params
  end


  def index
    @events = Events.all
    render some html and send it back
    render json: @json_data, :status => 200
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
