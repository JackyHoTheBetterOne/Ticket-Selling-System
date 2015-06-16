module Codey
  extend ActiveSupport::Concern

  included do
    before_create :add_code
  end

  def add_code()
    self["unique_code"] = rand(9999999999).to_s.center(20, rand(9).to_s) 
  end
end