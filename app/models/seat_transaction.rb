class SeatTransaction < ActiveRecord::Base
  belongs_to :seat
  belongs_to :transaction_log
end
