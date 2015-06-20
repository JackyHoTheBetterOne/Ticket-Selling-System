class Event::SeatUnholder
  attr_reader :event_id
  attr_reader :seat_selection

  def initialize(options={})
    @event_id = options[:event_id]
    @seat_selection = Seat.find_available_seats_by_name(
                        @event_id, options[:seat_selection])
  end


  def call()
    @seat_selection.each do |s|
      s.unholding
      s.save
    end
  end
end