class Event < ActiveRecord::Base
  has_many :seats, dependent: :destroy
end
