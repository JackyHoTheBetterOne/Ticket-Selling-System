class TransactionLog < ActiveRecord::Base

########################################################## Relationships
  has_one :ticket_package_transaction
  has_one :ticket_package, through: :ticket_package_transaction
  has_many :seat_transaction
  has_many :seats, through: :seat_transaction

########################################################## SQL queries

############################################################## Methods

end