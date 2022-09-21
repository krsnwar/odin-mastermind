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
    @code = []
  end

  def play
    new_game
    initial_settings
    start_game(@mode)
  end

  def new_game
    system "clear"
    @mode = nil
    @win = false
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
      tries = 1
      while (tries <= @max_tries and not @win)
        puts "Tries : #{tries}"
        check_valid_guess(receive_player_guess, true)
        tries += 1
      end
      if @win
        puts "CONGRATULATIONS YOU WON"
      elsif tries == @max_tries+1
        puts "GAME OVER | Max tries has been reached"
      end
    elsif mode == 2
      user_set_code
      puts "The computer will guess your code\nPress enter to let the computer guess each time/iteration"
      tries = 1
      while (tries <= @max_tries and not @win)
        puts "Tries : #{tries}"
        check_answer(computer_guess)
        input = gets
        until input == "\n" do
          puts "Please press enter to continue"
          input = gets
        end
        tries += 1
      end
      if @win
        puts "CONGRATULATIONS YOU WON"
      elsif tries == @max_tries+1
        puts "GAME OVER | Max tries has been reached"
      end
    end
  end

  def set_code
    while @code.length < 4 do
      value = rand(1..6).to_s
      # check repeat element
      unless @code.include?(value)
        @code.push(value)
      end
    end
  end

  def user_set_code
    check_valid_code(receive_player_code, true)
  end

  def computer_guess
    comp_ans = []
    while comp_ans.length < 4 do
      value = rand(1..6).to_s
      # check repeat element
      unless comp_ans.include?(value)
        comp_ans.push(value)
      end
    end
    comp_ans
  end

  def check_answer(guess)
    @hint = []
    @guesses = guess
    ref = @guesses.map { |x| @code.find_index(x)}
    ref.each do |ref_elm|
      if ref_elm
        if @guesses[ref_elm] == @code[ref_elm]
          @hint.push("R")
        else
          @hint.push("W")
        end
      end
    end
    show_user_input(guess)
    print "\tFeedback = "
    show_hint(@hint)
    validate_hint(@hint)
  end

  def validate_hint(hint)
    ref = ["R", "R", "R", "R"]
    if hint == ref
      @win = true
    end
  end

  def check_valid_guess(guess, valid)
    valid = guess.all? { |digit| digit.to_i.between?(1,6) }

    if valid
      check_answer(guess)
    else
      check_valid_guess(receive_player_guess("invalid"), true)
    end
    valid
  end

  def check_valid_code(code, valid)
    valid = code.all? { |digit| digit.to_i.between?(1,6) }

    if valid
      @code = code
      print "Your code is "
      show_user_input(@code)
      puts
    else
      check_valid_code(receive_player_code("invalid"), true)
    end
    valid
  end
  
end