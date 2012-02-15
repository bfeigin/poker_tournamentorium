class Game < ActiveRecord::Base
  has_many :hands
  belongs_to :tournament
  has_many :players, :through => :seatings, :conditions => {:active => true}

end
