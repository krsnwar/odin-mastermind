module Input

  # @lang = ["en", "id"]
  # @lang_en = {
  #   "select_role" => "Before playing, please select your role/mode\n",
  #   "role_choice" => "Press 1 to be a codebreaker | Press 2 to be a codemaker\n",
  #   "breaker" => "codebreaker",
  #   "maker" => "codemaker"
  # }
  # @lang_id = {
  #   "select_role" => "Sebelum memulai permainan, silahkan pilih mode\n",
  #   "role_choice" => "Ketik 1 untuk menjadi codebreaker | Ketik 2 untuk menjadi codemaker\n",
  #   "breaker" => "codebreaker",
  #   "maker" => "codemaker"
  # }

  def select_mode
    print "Before playing, please select your role/mode\n"
    print "Press 1 to be a codebreaker | Press 2 to be a codemaker\n"
  end

  def welcome_message
    output = <<~end
      +-----------------------------------------------------------------------+
      |                 You've chosen to be a codebreaker!!!                  |
      |   Your opponent has chosen a code, please make a guess in 12 tries.   |
      |  Please guess 4 set of color. Meanwhile there are 6 available color.  |
      +-----------------------------------------------------------------------+
      |                           Color Choices:                              |
      |     1. Red   2. Green   3. Blue   4. Yellow   5. White   6. Black     |
      +-----------------------------------------------------------------------+
      |         Hint: to guess set of color: Red, Black, Blue, Yellow         |
      |                          Please input: 1634                           |
      +-----------------------------------------------------------------------+
    end
    puts output.yellow
  end

  def receive_player_guess(incoming_request = "")
    if incoming_request == "invalid"
      puts "Your guess contain invalid character. Valid = {1, 2, 3, 4, 5, 6}"
      print "Please input your guess again: "
    else
      print "Please input your guess: "
    end
    user_input = gets.chomp
    until user_input.length == 4 do
      print "The guess set must be 4 character long.\nPlease input your guess again: "
      user_input = gets.chomp
    end
    user_input
  end

end