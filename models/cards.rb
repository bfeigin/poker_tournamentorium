class Card < ActiveRecord::Base
  belongs_to :dealable, :polymorphic => true
  belongs_to :hand, :foreign_key => 'hand_id'


  def to_s
    (value_code.to_s + suit_code.to_s).downcase
  end

  def <=> other_card
    face <=> other_card.face
  end
  
  #def is_a?(klass)
  #  klass == Card || self === klass
  #end

  def == other_card
    face == other_card.face && suit_code == other_card.suit_code
  end
  alias :eql? :==

  def face
    self.class.face_value(value_code)
  end
  alias :face_value :face

  def suit
    case suit_code.downcase
    when 'c'
      0
    when 'd'
      1
    when 'h'
      2
    when 's'
      3
    end
  end

  def suit_name
    case suit_code.upcase
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

  # Return just the basic info.
  def as_json(opts={})
    {
      :suit => suit_code.to_s,
      :value => value_code.to_s
    }
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

