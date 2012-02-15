class Player < ActiveRecord::Base
  belongs_to :tournament
  has_one :seating
  has_many :games, :through => :seatings do
    def current_game
      where(:active => true)
    end
  end

  validates_presence_of :tournament

end
