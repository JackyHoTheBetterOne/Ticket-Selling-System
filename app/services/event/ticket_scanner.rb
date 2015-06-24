class Event::TicketScanner
  attr_accessor :event
  attr_accessor :barcode

  def initialize(options={})
    @event = Event.find_by_name(options[:event_name])
    @barcode = options[:barcode]
  end

  def call()
    ticket = Ticket.find_ticket_by_barcode(@event.id, @barcode)

    if ticket.aasm_state == "valid" && @event.show_date.to_date == Time.now.to_date
      ticket.scanning
      ticket.save
      return {}
    else 
      return {error: "Bad ticket"}
    end
  end
end