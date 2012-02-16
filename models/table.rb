class Table < ActiveRecord::Base
  has_many :hands
  belongs_to :tournament
  has_many :players, :through => :seatings, :conditions => {:active => true}

  def initialize
    super
    self.game_type ||= :texas_holdem
  end

  def begin_new_hand!
  end

end
