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

    checker = Event::SeatAvailabilityChecker.new({
                event_id: @event.id,
                seat_selection: params[:seat_selection],
                rules_broken: !selector.result
              })

    checker.check_and_update()

    render json: checker.invalid_seat_object
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
