require 'aasm'

class Ticket < ActiveRecord::Base
  include AASM

########################################################## Relationships
  belongs_to :seat
  belongs_to :event

 
########################################################## SQL queries
  scope :find_seat_by_unique_code, -> (event_id, code) {
    where(:event_id => event_id).where(:unique_code => code)
  }


########################################################## AASM states
  aasm do 
  end


############################################################## Methods
  def add_code
    self["barcode"] = rand(9999999999).to_s.center(20, rand(9).to_s) 
    if Ticket.find_ticket_by_barcode(self.event_id, self.unique_code).first
      add_code()
    end
  end

end
