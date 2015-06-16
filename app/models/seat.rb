require 'aasm'

class Seat < ActiveRecord::Base
  include AASM

########################################################## Relationships
  belongs_to :event


########################################################## SQL queries
  scope :find_seat_by_unique_code, -> (event_id, code) {
    where(:event_id => event_id).where(:unique_code => code)
  }


########################################################## AASM states

  aasm do 
    state :empty, :initial => true
    state :reserved
    state :onhold
    state :purchased
    event :reservation do 
      transitions :from => :empty, :to => :reserved
    end

    event :holding do 
      transitions :from => :empty, :to => :onhold
    end

    event :unholding do 
      transitions :from => :onhold, :to => :empty
    end

    event :purchase do
      transitions :from => :reserved, :to => :purchased 
      transitions :from => :empty, :to => :purchased
    end
  end



############################################################## Methods

  def add_code
    self["unique_code"] = rand(9999999999).to_s.center(20, rand(9).to_s) 
    if Seat.find_seat_by_unique_code(self.event_id, self.unique_code).first
      add_code()
    end
  end


end
