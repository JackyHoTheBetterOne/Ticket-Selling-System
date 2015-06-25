class TicketPackage < ActiveRecord::Base
  has_many :tickets, dependent: :destroy
  has_many :seats, through: :tickets
  belongs_to :event

  scope :search_by_keywords, -> (event_id, keyword) {
    if keyword.present?
      where(:event_id => event_id).where("keywords LIKE ?", "%#{keyword.downcase}%")
    else
      where(:event_id => event_id)
    end
  }

  def make_keywords
    self.keywords = [name, email].map(&:downcase).join(" ")
  end
end
