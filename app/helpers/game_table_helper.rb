# Helper methods defined here can be accessed in any controller or view in the application

EnovaPoker.helpers do
  # def simple_helper_method
  #  ...
  # end
  def suit_symbol(suit_code)
    case suit_code
      when "C" 
        "<div class='card black'>&clubs;</div>"
      when "S" 
        "<div class='card black'>&spades;</div>"
      when "D" 
        "<div class='card red'>&diams;</div>"
      when "H" 
        "<div class='card red'>&hearts;</div>"
      else ""
    end
  end
end 
