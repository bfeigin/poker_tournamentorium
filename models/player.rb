class Player < ActiveRecord::Base
  belongs_to :tournament
  has_one :seating
  has_many :tables, :through => :seatings do
    def current_table
      where(:active => true)
    end
  end

  validates_presence_of :tournament

end
