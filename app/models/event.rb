require 'aasm'

class Event < ActiveRecord::Base
  include AASM
  extend FriendlyId

  validates :name, uniqueness: true, presence: true
  friendly_id :name


########################################################## Relationships
  has_many :seats, dependent: :destroy
  has_many :price_groups, dependent: :destroy
  has_many :priced_seats, through: :price_groups, source: :seats
  has_many :tickets, through: :seats, dependent: :destroy
  has_many :ticket_packages


########################################################## SQL queries
  scope :upcoming, -> {
    sort_by(aasm_state)
  }

  scope :available, -> {
    where(aasm_state: 'upcoming')
  }


########################################################## AASM states
  aasm do
    state :planning, :initial => true
    state :upcoming
    state :live
    state :complete

    event :finish_planning do
      transitions :from => :planning, :to => :upcoming
      #Make sure all seats are priced before continuing
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
    return self.priced_seats.count == self.seats
  end

  def self.today
    self.available.select {|e| e.show_date.to_date == Time.now.to_date}
  end

  def got_tickets?
    return self.tickets.count == 0 ? false : true
  end

end
