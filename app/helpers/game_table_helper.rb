# Helper methods defined here can be accessed in any controller or view in the application

EnovaPoker.helpers do
  # def simple_helper_method
  #  ...
  # end
  def build_card(number, suit_code)
    card = "<div class='card'>"
    card << (number == "T" ? "10" : number)
    case suit_code
      when "C" 
        card << "<div class='suit black'>&clubs;</div>"
      when "S" 
        card << "<div class='suit black'>&spades;</div>"
      when "D" 
        card << "<div class='suit red'>&diams;</div>"
      when "H" 
        card << "<div class='suit red'>&hearts;</div>"
    end
    card << "</div>"
    card
  end

  def build_hand(hand_string)
    cards = hand_string.split("(").first.split(" ")
    cards.collect { |c| build_card(c[0..0], c[1..1].to_upper) }.join(" ")
  end
end 
