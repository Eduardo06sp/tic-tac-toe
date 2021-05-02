class TicTacToe
  def initialize(player_one_name, player_two_name, player_one_symbol, player_two_symbol, game_board)
    @player_one_name = player_one_name
    @player_two_name = player_two_name
    @player_one_symbol = player_one_symbol
    @player_two_symbol = player_two_symbol
    @game_board = game_board
    @player_one_score = 0
    @player_two_score = 0
  end
end

class GameBoard
  def initialize
    @board = { A1: ' ', B1: ' ', C1: ' ',
               A2: ' ', B2: ' ', C2: ' ',
               A3: ' ', B3: ' ', C3: ' ' }
  end
end

puts 'Welcome! You will be playing Tic-Tac-Toe in the command line. This is set up for a human vs human.'
puts "Please enter player one's name (or just press enter to use the default)"

player_one_name = gets.chomp
player_one_name = player_one_name == '' ? 'player_one' : player_one_name

player_one_symbol = nil
until %w[X O].include?(player_one_symbol)
  puts "#{player_one_name}, choose \"X\" or \"O\"!"
  player_one_symbol = gets.chomp.upcase
end

puts "Enter player two's name"
player_two_name = gets.chomp
player_two_name = player_two_name == '' ? 'player_two' : player_two_name

player_two_symbol = player_one_symbol == 'X' ? 'O' : 'X'

new_game_board = GameBoard.new
new_match = TicTacToe.new(player_one_name, player_two_name, player_one_symbol, player_two_symbol, new_game_board)
