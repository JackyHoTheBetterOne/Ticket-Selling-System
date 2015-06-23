class Event::SeatAvailabilityChecker
  attr_reader :rules_broken
  attr_reader :event_id
  attr_reader :seat_selection
  attr_reader :taken_seats
  attr_reader :invalid_seat_object

  def initialize(options={})
    @event_id = options[:event_id]
    collection = options[:seat_selection]
    @seat_selection = Seat.find_available_seats_by_name(@event_id, collection)
    @taken_seats = []
    @invalid_seat_object = {}
    @invalid_seat_object["seats_to_remove"] = []
    @invalid_seat_object["rules_broken"] = options[:rules_broken]
  end

  def check_and_update()
    if !@invalid_seat_object["rules_broken"]
      @seat_selection.each do |s|
        @taken_seats.push(s) if s.aasm_state != 'available'
      end

      @taken_seats.each do |s|
        @invalid_seat_object["seats_to_remove"].push(s.name)
      end
    end

    if !@invalid_seat_object["rules_broken"] && @invalid_seat_object["seats_to_remove"].length == 0
      @seat_selection.each do |s|
        s.holding
        s.save
        s.check_and_update_seat_status
      end
    end

    return @invalid_seat_object
  end
end