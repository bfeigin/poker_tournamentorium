class Action < ActiveRecord::Base
  belongs_to :player
  belongs_to :round

  def is_fold?
    return action_name == 'fold'
  end

end
