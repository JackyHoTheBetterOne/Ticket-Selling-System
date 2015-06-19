class PriceGroup < ActiveRecord::Base
########################################################## Relationships
  belongs_to :event
  has_many :seats
########################################################## SQL queries
############################################################## Methods
end
