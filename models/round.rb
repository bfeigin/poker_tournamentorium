class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

end
