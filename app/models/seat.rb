require 'aasm'

class Seat < ActiveRecord::Base
  include AASM

########################################################## Relationships
  belongs_to :event
  has_one :ticket


########################################################## SQL queries


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




end
