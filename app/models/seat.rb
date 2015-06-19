require 'aasm'

class Seat < ActiveRecord::Base
  include AASM

########################################################## Relationships
  belongs_to :event
  has_one :ticket, dependent: :destroy

########################################################## SQL queries
  scope :find_available_seats_by_column_range, -> (event_id, row, range_1, range_2, status='available') {
    column_collection_on_range = range_1 > range_2 ? [*range_2..range_1] : [*range_1..range_2]
    where(:event_id => event_id).where(:column => column_collection_on_range, 
                                        :row => row,
                                        :aasm_state => status)
  }

  scope :find_available_seats_by_name, -> (event_id, names) {
    where(:event_id => event_id).where(name: names)
  }

  scope :find_seats_by_status, -> (event_id, status='available') {
    where(:event_id => event_id).where(:aasm_state => status)
  }

########################################################## AASM states

  aasm do 
    state :available, :initial => true
    state :reserved
    state :onhold
    state :purchased
    event :reservation do 
      transitions :from => :available, :to => :reserved
    end

    event :holding do 
      transitions :from => :available, :to => :onhold
    end

    event :unholding do 
      transitions :from => :onhold, :to => :available
    end

    event :purchase do
      transitions :from => :reserved, :to => :purchased 
      transitions :from => :available, :to => :purchased
    end
  end



############################################################## Methods
  def make_name
    self.name = self.row + self.column
  end
end
