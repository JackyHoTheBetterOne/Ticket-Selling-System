class TicketPackage < ActiveRecord::Base
  has_many :tickets, dependent: :destroy
  has_many :seats, through: :tickets
end
