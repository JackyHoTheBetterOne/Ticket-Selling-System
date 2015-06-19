class Onlineticketing::EventsController < ApplicationController
  def seat_view
    find_event()
  end

  def seat_selection
    find_event()

    selector = Event::SeatSelection.new({
      event: @event,
      seat_selection: params[:seat_selection]
    })

    selector.call()

    if selector.result
      # @selected_seats = selector.seat_selection
      render text: 'Good to go'
    else
      # redirect_to seat_view_onlineticketing_event_path(@event)
      render text: 'Nope'
    end
  end

  def seat_update
    find_event()
    @seats = @event.seats
  end




  private

  def find_event()
    @event = Event.friendly.find(params[:id])
  end
end
