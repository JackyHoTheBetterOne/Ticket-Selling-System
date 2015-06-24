require 'aasm'

class Ticket < ActiveRecord::Base
  include AASM

########################################################## Relationships
  belongs_to :seat
  belongs_to :event
  belongs_to :ticket_package

 
########################################################## SQL queries
  scope :find_ticket_by_barcode, -> (event_id, code) {
    where(:event_id => event_id).where(:barcode => code)
  }


########################################################## AASM states
  aasm do
    state :valid, :initial => true 

    event :scanning do 
      transitions :from => :valid, :to => :scanned
    end


  end


############################################################## Methods
  def add_code
    o = [('a'..'z'), (0..9), ('A'..'Z'), (0..9)].map { |i| i.to_a }.flatten
    string = (0..19).map { o[rand(o.length)] }.join
    self["barcode"] = string
    if Ticket.find_ticket_by_barcode(self.event_id, self.barcode).first
      add_code()
    end
  end
end
