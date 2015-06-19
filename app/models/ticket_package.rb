class TicketPackage < ActiveRecord::Base
  has_many :ticekts, dependent: :destroy
end
