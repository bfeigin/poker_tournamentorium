class Round < ActiveRecord::Base
  belongs_to :hand
  has_many :actions

  def close!
    self[:open] = false
    save!
    self
  end

end
