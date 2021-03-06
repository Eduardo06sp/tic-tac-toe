# frozen_string_literal: true

require_relative '../tic_tac_toe'
require_relative '../game_board'
require_relative '../possibilities'
require_relative '../player'

describe TicTacToe do
  let(:board) { GameBoard.new }
  let(:possibilities) { Possibilities.new }
  let(:player1) { Player.new('p1', 'X') }
  let(:player2) { Player.new('p2', 'O') }
  subject(:new_game) { described_class.new(player1, player2, board, possibilities) }

  before do
    allow(new_game).to receive(:puts)
    allow(new_game).to receive(:gets).and_return('p1')
    allow(board).to receive(:space_empty?).and_return(true)
    allow(board).to receive(:update)
    allow(possibilities).to receive(:update)
  end

  describe '#winner?' do
    context 'when player performs a winning move'

    it 'returns true when board reads X X X across top row' do
      horizontal_win = { A1: 'X', B1: 'X', C1: 'X',
                         A2: ' ', B2: ' ', C2: ' ',
                         A3: ' ', B3: ' ', C3: ' ' }
      board.instance_variable_set(:@board, horizontal_win)

      allow(new_game).to receive(:rematch)
      expect(new_game).to receive(:end_match)
      new_game.play_rounds
    end

    it 'returns true when board reads X X X diagonally' do
      diagonal_win = { A1: 'X', B1: ' ', C1: ' ',
                       A2: ' ', B2: 'X', C2: ' ',
                       A3: ' ', B3: ' ', C3: 'X' }
      board.instance_variable_set(:@board, diagonal_win)

      allow(new_game).to receive(:rematch)
      expect(new_game).to receive(:end_match)
      new_game.play_rounds
    end

    it 'returns true when board reads X X X vertically' do
      vertical_win = { A1: 'X', B1: ' ', C1: ' ',
                       A2: 'X', B2: ' ', C2: ' ',
                       A3: 'X', B3: ' ', C3: ' ' }
      board.instance_variable_set(:@board, vertical_win)

      allow(new_game).to receive(:rematch)
      expect(new_game).to receive(:end_match)
      new_game.play_rounds
    end

    it 'returns true when last possible move results in win' do
      winning_move = { A1: 'X', B1: 'O', C1: 'O',
                       A2: 'X', B2: 'X', C2: 'X',
                       A3: 'X', B3: 'O', C3: 'O' }
      board.instance_variable_set(:@board, winning_move)

      allow(new_game).to receive(:rematch)
      expect(new_game).to receive(:end_match)
      new_game.play_rounds
    end
  end

  describe '#tie?' do
    context 'when neither player wins'

    it 'returns true' do
      tied_game = { A1: 'X', B1: 'O', C1: 'X',
                    A2: 'X', B2: 'X', C2: 'O',
                    A3: 'O', B3: 'X', C3: 'O' }
      board.instance_variable_set(:@board, tied_game)

      allow(new_game).to receive(:display_game)
      allow(new_game).to receive(:rematch)
      expect(new_game).to receive(:puts).with("It's a tie!")
      new_game.play_rounds
    end
  end

  describe '#play_rounds' do
    it 'runs until game is a tie / there is a winner' do
      unfinished_game = { A1: ' ', B1: ' ', C1: ' ',
                          A2: ' ', B2: 'X', C2: ' ',
                          A3: ' ', B3: ' ', C3: ' ' }
      board.instance_variable_set(:@board, unfinished_game)

      allow(new_game).to receive(:display_game)
      allow(new_game).to receive(:change_turn)
      expect(new_game).to receive(:play_rounds)
      new_game.play_rounds
    end
  end
end
