class Tournament < ActiveRecord::Base
  has_many :players
  has_many :games

end
