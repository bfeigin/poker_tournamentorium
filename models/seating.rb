class Seating < ActiveRecord::Base
  belongs_to :player
  belongs_to :table

end
