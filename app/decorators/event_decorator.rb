class EventDecorator
  attr_reader :event

  def initialize(event)
    @event = event
    @seat_count = event.seats.count
  end


  def total_seat_count
    @event.seats.count
  end

  def remaining_seat_count
    Seat.find_seats_by_status(@event.id).count
  end

  def sold_seat_count
    Seat.find_seats_by_status(@event.id, 'purchased').count
  end

  def reserved_seat_count
    Seat.find_seats_by_status(@event.id, 'reserved').count
  end


  def method_missing(method_name, *args, &block)
    event.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    event.respond_to?(method_name, include_private) || super
  end

end
