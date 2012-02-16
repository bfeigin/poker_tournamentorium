class GameTable < ActiveRecord::Base
  has_many :hands 
  belongs_to :tournament
  has_many :players, :through => :seatings, :conditions => {:active => true}

  def begin_hand
    return hands.find_or_create_by_active(true)
  end

end
