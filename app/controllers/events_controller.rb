class EventsController < ApplicationController
  def seat_selection
    event_name = params[:event_name]
    seat_selection = params[:seat_selection]
    @event = Event.find_by_name(event_name)
    seats = Seat.find_available_seats_by_name(@event.id, seat_selection)
    seat_checker = SeatSelectionValidator.new({
      seat_collection: seats,
      event_id: @event.id
    })
    result = seat_checker.validation()

    if result
      render text: 'Good to go'
    else
      render text: 'Nope'
    end
  end
end
