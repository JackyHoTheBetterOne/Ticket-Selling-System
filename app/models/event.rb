require 'aasm'

class Event < ActiveRecord::Base
  include AASM


########################################################## Relationships
  has_many :seats, dependent: :destroy
  has_many :tickets, through: :seats, dependent: :destroy
    
    
########################################################## SQL queries


########################################################## AASM states
  aasm do 
  end


############################################################## Methods


end
