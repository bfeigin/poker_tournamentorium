class Player < ActiveRecord::Base
  belongs_to :tournament
  has_many :hands
  has_many :actions


  validates_presence_of :tournament

end
