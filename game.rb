require "colorize"
require_relative "input.rb"
require_relative "show.rb"

class Game
  include Input
  include Show
  
  def initialize
    @guesses
    @max_tries = 12
    @win = false
  end

  def play
    new_game
    initial_settings
    start_game(@mode)
  end

  def new_game
    system "clear"
    @mode = nil
  end
  
  def initial_settings
    select_mode
    @mode = gets.chomp.to_i
    until @mode.between?(1,2)
      puts "!!! Please press 1 or 2 !!!"
      select_mode
      @mode = gets.chomp.to_i
    end
    puts "Mode you've chosen: #{@mode == 1 ? "codebreaker" : "codemaker"}"
  end

  def start_game(mode)
    if mode == 1
      set_code
      welcome_message
      @max_tries.times do
        check_valid_guess(receive_player_guess, true)
      end
    elsif mode == 2
      puts "AI Logic hasn't been made, yet"
    end
  end

  def set_code
    @code = []
    4.times do |index|
      @code[index] = rand(1..6).to_s
    end
    print @code
    puts
  end

  def check_answer(guess)
    @guesses = guess.to_s.split("")
    print "#{@code}\n"
    print "#{@guesses}\n"
    print "#{(@guesses - @code)}\n"
    show_user_input(guess)
  end

  def check_valid_guess(guess, valid)
    guess.each_char do |digit|
      unless digit.to_i.between?(1, 6)
        valid = false
      end
    end

    if valid
      check_answer(guess)
    else
      check_valid_guess(receive_player_guess("invalid"), true)
    end
    valid
  end

end