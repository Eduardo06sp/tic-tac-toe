# TerminalInterface contains styling used to display the banner, gameboard, possibilities board and score
module TerminalInterface
  def display_title
    puts "----------------------------------------------------------
    \n------------ TIC - TAC - TOE -----
    \n-----------------------------------------------------"
  end

  def display_board
    puts "\t    |   |        |       |    | \n" \
      "\t  #{board[:A1]} | #{board[:B1]} | #{board[:C1]}      |    " \
      "#{possibilities[:A1]} | #{possibilities[:B1]} | #{possibilities[:C1]}\n" \
      "\t----|---|----    |   ----|----|----\n" \
      "\t  #{board[:A2]} | #{board[:B2]} | #{board[:C2]}      |    " \
      "#{possibilities[:A2]} | #{possibilities[:B2]} | #{possibilities[:C2]}\n" \
      "\t----|---|----    |   ----|----|----\n" \
      "\t  #{board[:A3]} | #{board[:B3]} | #{board[:C3]}      |    " \
      "#{possibilities[:A3]} | #{possibilities[:B3]} | #{possibilities[:C3]}\n" \
      "\t    |   |        |       |    | "
  end

  def display_score
    puts "-----------------------------------------------------------
    \n ------Score: ---- #{player_one_name}: #{player_one_score} -------- #{player_two_name}: #{player_two_score} ------
    \n ---------------------------------------------------------"
  end
end

class TicTacToe
  include TerminalInterface

  attr_accessor :turn, :board, :possibilities, :player_one_score, :player_two_score
  attr_reader :player_one_name, :player_two_name, :player_one_symbol, :player_two_symbol

  def initialize(player_one_name, player_two_name, player_one_symbol, player_two_symbol)
    @player_one_name = player_one_name
    @player_two_name = player_two_name
    @player_one_symbol = player_one_symbol
    @player_two_symbol = player_two_symbol
    @player_one_score = 0
    @player_two_score = 0
    @board = { A1: ' ', B1: ' ', C1: ' ',
               A2: ' ', B2: ' ', C2: ' ',
               A3: ' ', B3: ' ', C3: ' ' }
    @possibilities = { A1: 'A1', B1: 'B1', C1: 'C1',
                       A2: 'A2', B2: 'B2', C2: 'C2',
                       A3: 'A3', B3: 'B3', C3: 'C3' }
    @turn = player_one_name
  end

  def display_game
    display_title
    display_board
    display_score
  end

  def space_empty?(play)
    board[play.to_sym] == ' '
  end

  def update_board(play, player_symbol)
    board[play.to_sym] = player_symbol

    possibilities[play.to_sym] = %i[C1 C2 C3].include?(play.to_sym) ? player_symbol.to_s : " #{player_symbol}"
  end

  def winner?(player_symbol)
    win_possibilities = [
      %w[A1 B1 C1],
      %w[A2 B2 C2],
      %w[A3 B3 C3],

      %w[A1 A2 A3],
      %w[B1 B2 B3],
      %w[C1 C2 C3],

      %w[A1 B2 C3],
      %w[A3 B2 C1]
    ]

    player_spaces_hash = board.select do |space|
      board[space] == player_symbol
    end

    player_spaces_array = player_spaces_hash.to_a.flatten
    player_spaces_symbols = player_spaces_array.select do |el|
      el.is_a?(Symbol)
    end
    player_symbols_array = player_spaces_symbols.map do |sym|
      sym.to_s
    end

    win_possibilities.any? do |possibility|
      possibility.all? { |el| player_symbols_array.include?(el) }
    end
  end

  def change_turn
    self.turn = turn == player_one_name ? player_two_name : player_one_name
  end

  def end_match(player)
    if player == player_one_name
      self.player_one_score += 1
    else
      self.player_two_score += 1
    end

    display_game

    puts "Congratulations #{player}, you've won!"
    puts 'Rematch?'
    input = gets.chomp.strip

    until %w[yes y no n].include?(input)
      puts 'Please enter yes or no.'
      input = gets.chomp.strip
    end

    if %w[yes y].include?(input)
      self.board = { A1: ' ', B1: ' ', C1: ' ',
                 A2: ' ', B2: ' ', C2: ' ',
                 A3: ' ', B3: ' ', C3: ' ' }

      self.possibilities = { A1: 'A1', B1: 'B1', C1: 'C1',
                             A2: 'A2', B2: 'B2', C2: 'C2',
                             A3: 'A3', B3: 'B3', C3: 'C3' }
      display_game
      play_rounds
    else
      puts 'Have a wonderful day! Thanks for playing :}'
    end
  end

  def play_rounds
    puts "#{turn}, make your move."

    play = gets.chomp.upcase
    until space_empty?(play)
      puts 'Please choose an available space!'
      play = gets.chomp.upcase
    end

    player_symbol = turn == player_one_name ? player_one_symbol : player_two_symbol
    update_board(play, player_symbol)

    if winner?(player_symbol)
      end_match(turn)
    else
      display_game
      change_turn
      play_rounds
    end
  end
end

def intro
  puts 'Welcome! You will be playing Tic-Tac-Toe in the command line. This is set up for a human vs human.'
  puts "Please enter player one's name (or just press enter to use the default)"

  player_one_name = gets.chomp
  player_one_name = player_one_name == '' ? 'player_one' : player_one_name

  player_one_symbol = nil
  until %w[X O].include?(player_one_symbol)
    puts "#{player_one_name}, choose \"X\" or \"O\"!"
    player_one_symbol = gets.chomp.upcase
  end

  puts "Enter player two's name (or press enter to use the default)"
  player_two_name = gets.chomp
  player_two_name = player_two_name == '' ? 'player_two' : player_two_name

  player_two_symbol = player_one_symbol == 'X' ? 'O' : 'X'

  new_match = TicTacToe.new(player_one_name, player_two_name, player_one_symbol, player_two_symbol)

  new_match.display_game
  new_match.play_rounds
end

intro
