class TicketPackageTransaction < ActiveRecord::Base
  belongs_to :ticket_package
  belongs_to :transaction_log
end
