class HandStartStat < ActiveRecord::Base
  belongs_to :player
  belongs_to :hand
end
