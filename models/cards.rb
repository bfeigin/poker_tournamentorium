class Card < ActiveRecord::Base
  belongs_to :player
  belongs_to :hand

  def ace?
    face_value == 14
  end

  def face_value
    case self[:value]
    when 'T'
      10
    when 'J'
      11
    when 'Q'
      12
    when 'K'
      13
    when 'A'
      14
    else
      self[:value]
    end
  end

  def suit_name
    case self[:suit]
    when 'C'
      'Clubs'
    when 'D'
      'Diamonds'
    when 'H'
      'Hearts'
    when 'S'
      'Spades'
    end
  end

end

