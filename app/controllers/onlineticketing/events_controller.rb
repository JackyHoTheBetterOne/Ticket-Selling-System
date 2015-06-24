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

  def seat_purchase
    find_event()

    purchaser = Event::SeatPurchaser.new({
                  event_id: @event.id,
                  customer_email: params[:customer_email],
                  customer_name: params[:customer_name],
                  seat_selection: params[:seat_selection],
                  stripe_token: params[:stripe_token]
                })

    purchaser.call()

    render text: purchaser.is_successful.to_s

  end

  def seat_unhold
    find_event()

    unholder= Event::SeatUnholder.new({
                seat_selection: params[:seat_selection],
                event_id: @event.id
              })

    unholder.call()

    render nothing: true
  end

  def ticket_scan
    allowance()

    scanner = TicketScanner.new({
                event_name: params[:event_name],
                barcode: params[:barcode]
              })

    render json: scanner.call()
  end

  def event_listing
    @events = Event.all
  end


  private

  def find_event()
    @event = Event.friendly.find(params[:id])
  end

  def allowance()
    if request.format == "application/json"
      response.headers["Access-Control-Allow-Origin"] = "*"
    end
  end
end
