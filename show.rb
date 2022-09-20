require "colorize"

module Show
  def show_user_input(guess)
    guess.each_char do |color|
      case color
      when "1"
        print "\u2b24 ".red
      when "2"
        print "\u2b24 ".green
      when "3"
        print "\u2b24 ".blue
      when "4"
        print "\u2b24 ".yellow
      when "5"
        print "\u2b24 ".white
      when "6"
        print "\u2b24 ".black
      end
    end
    puts
  end
end