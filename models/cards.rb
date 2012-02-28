class Card < ActiveRecord::Base
  belongs_to :dealable, :polymorphic => true
  belongs_to :hand, :foreign_key => 'hand_id'

  def to_code
    value_code.to_s + suit_code.to_s
  end

  def to_html
    if suit_code.to_s == "C"
      return "&clubs;"
    end
  end

  def face_value
    self.class.face_value(value_code)
  end

  def suit_name
    self.class.suit_name(suit_code)
  end

  # Return just the basic info.
  def as_json(opts={})
    {
      :suit => suit_code.to_s,
      :value => value_code.to_s
    }
  end

  def self.suit_name
    case suit.upcase
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

  def self.face_value(value)
    case value.upcase
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
      value.to_i
    end
  end

end

