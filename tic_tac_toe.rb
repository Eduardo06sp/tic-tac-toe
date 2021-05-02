module TerminalInterface
  def display_title
    puts "----------------------------------------------------------
    \n------------ TIC - TAC - TOE -----
    \n-----------------------------------------------------"
  end

  def display_board_and_moves
    game_board =
      "\t    |   |        |       |    | \n" \
      "\t  #{board[:A1]} | #{board[:B1]} | #{board[:C1]}      |    " \
      "#{possibilities[:A1]} | #{possibilities[:B1]} | #{possibilities[:C1]}\n" \
      "\t----|---|----    |   ----|----|----\n" \
      "\t  #{board[:A2]} | #{board[:B2]} | #{board[:C2]}      |    " \
      "#{possibilities[:A2]} | #{possibilities[:B2]} | #{possibilities[:C2]}\n" \
      "\t----|---|----    |   ----|----|----\n" \
      "\t  #{board[:A3]} | #{board[:B3]} | #{board[:C3]}      |    " \
      "#{possibilities[:A3]} | #{possibilities[:B3]} | #{possibilities[:C3]}\n" \
      "\t    |   |        |       |    | "

    puts game_board
  end

  def display_score
    puts "-----------------------------------------------------------
    \n ------Score: ---- #{player_one_name}: #{player_one_score} -------- #{player_two_name}: #{player_two_score} ------
    \n ---------------------------------------------------------"
  end
end

class TicTacToe
  include TerminalInterface

  attr_reader :board, :possibilities, :player_one_name, :player_two_name, :player_one_symbol, :player_two_symbol, :player_one_score, :player_two_score

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
  end

  def display_game
    display_title
    display_board_and_moves
    display_score
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
end

intro
