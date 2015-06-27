require 'aasm'
class TicketPackage < ActiveRecord::Base
include AASM
########################################################## Relationships
  belongs_to :event
  has_many :tickets, dependent: :destroy
  has_many :seats, through: :tickets
  has_many :ticket_package_transactions
  has_many :transaction_logs, through: :ticket_package_transactions

########################################################## SQL queries
  scope :search_by_keywords, -> (event_id, keyword) {
    if keyword.present?
      where(:event_id => event_id).where("keywords LIKE ?", "%#{keyword.downcase}%")
    else
      where(:event_id => event_id)
    end
  }
########################################################## AASM states
  aasm do
    state :valid, :initial => true
    state :deleted

    event :finish_planning do
      transitions :from => :valid, :to => :deleted
      #Make sure to set deleted at time when transitioning
    end
  end

############################################################## Methods
  def delete_self
    #Update deleted at time
  end

  def make_keywords
    self.keywords = [name, email].map(&:downcase).join(" ")
  end

end
