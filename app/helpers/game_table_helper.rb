# Helper methods defined here can be accessed in any controller or view in the application

EnovaPoker.helpers do
  # def simple_helper_method
  #  ...
  # end
  def build_card(number, suit_code)
    card = "<div class='card'>"
    card << number
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
end 
