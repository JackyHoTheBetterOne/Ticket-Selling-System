class Ssmanagment::EventsController < Ssmanagment::BaseController
  respond_to :json, only: []

  def index
    @events = Event.all
  end

  def new
  end

  def create
    @event = Event.create event_params
    seat_creator = Event::SeatCreator.new({event_id: @event.id})
    seat_creator.make_seats()
    flash[:notice] = "Event successfully created!"
    redirect_to ssmanagment_events_path
  end

  def copy
  end

  def show
  end

  def update
    find_event()
    @event.update_attributes(event_params)
    @event.save
    flash[:notice] = "Event successfully updated!"
    redirect_to ssmanagment_events_path
  end

  def destroy
    find_event()
    if @event.got_tickets?
      flash[:alert] = "Cannot destroy an event with paid customers!"
    else
      flash[:notice] = "Event successfully deleted!"
      @event.destroy
    end
    redirect_to ssmanagment_events_path
  end

  def admin
    find_event()
    @event = EventDecorator.new(@event)
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :show_date,
                                  :service_fee, :facility_fee )
  end

  def find_event
    @event = Event.friendly.find(params[:id])
  end


end
