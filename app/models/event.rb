require 'aasm'

class Event < ActiveRecord::Base
  include AASM
  extend FriendlyId

  validates :name, uniqueness: true, presence: true
  friendly_id :name


########################################################## Relationships
  has_many :seats, dependent: :destroy
  has_many :priced_seats, dependent: :destroy
  has_many :priced_seats, through: :price_groups, source: :seats
  has_many :tickets, through: :seats, dependent: :destroy
  has_many :ticket_packages, through: :tickets


########################################################## SQL queries
    scope :upcoming, -> { sort_by(aasm_state)
  }


########################################################## AASM states
  aasm do
    state :planning, :initial => true
    state :upcoming
    state :live
    state :complete

    event :finish_planning do
      transitions :from => :planning, :to => :upcoming if all_seats_priced?
    end

    event :event_date do
      transitions :from => :upcoming, :to => :live
    end

    event :completed do
      transitions :from => :live, :to => :complete
    end

  end

############################################################## Methods

  def all_seats_priced?
    # check to see if all seats have been priced
  end

end
