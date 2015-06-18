class EventsController < ApplicationController
  def seat_selection
    find_event()

    selector = Event::SeatSelection.new({
      event: @event,
      seat_selection: params[:seat_selection]
    })

    selector.call()

    if selector.result
      render text: 'Good to go'
    else
      render text: 'Nope'
    end
  end

  private

  def find_event()
    @event = Event.find(params[:id])
  end

end
