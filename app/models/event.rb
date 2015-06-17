require 'aasm'

class Event < ActiveRecord::Base
  include AASM
  extend FriendlyId

  validates :name, uniqueness: true, presence: true
  friendly_id :name


########################################################## Relationships
  has_many :seats, dependent: :destroy
  has_many :tickets, through: :seats, dependent: :destroy
    
    
########################################################## SQL queries


########################################################## AASM states
  aasm do 
    state :upcoming, :initial => true
  end


############################################################## Methods


end
