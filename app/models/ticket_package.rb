class TicketPackage < ActiveRecord::Base
  has_many :tickets, dependent: :destroy
  has_many :seats, through: :tickets


  scope :search_by_email, -> (email) {
    where(:email => email)
  }

end
