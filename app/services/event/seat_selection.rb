class Event::SeatSelection
  attr_reader :event
  attr_reader :seat_selection
  attr_reader :result

  def initialize(options={})
    @event = options[:event]
    @seat_selection = Seat.find_available_seats_by_name(
                        @event.id, options[:seat_selection])
  end

  def call
    seat_checker = Event::SeatSelectionValidator.new({
      seat_collection: @seat_selection,
      event_id: @event.id
    })
    @result = seat_checker.validation()
  end
end