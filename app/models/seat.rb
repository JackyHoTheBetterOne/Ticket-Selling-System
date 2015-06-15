require 'aasm'

class Seat < ActiveRecord::Base
  include AASM
  include Codey


  aasm do 
    state :empty, :initial => true
    state :reserved
    state :onhold
    state :purchased
  end

  event :reservation do 
    transition :from => :empty, :to => :reserved
  end

  event :holding do 
    transition :from => :empty, :to => :onhold
  end

  event :unholding do 
    transition :from => :onhold, :to => :empty
  end

  event :purchase do
    transition :from => :reserved, :to => :purchased 
    transition :from => :empty, :to => :purchased
  end

end
