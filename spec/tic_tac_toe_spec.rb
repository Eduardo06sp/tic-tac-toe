# frozen_string_literal: true

require_relative '../tic_tac_toe'
require_relative '../game_board'
require_relative '../possibilities'
require_relative '../player'

describe TicTacToe do
  describe '#winner?' do
    let(:board) { GameBoard.new }
    let(:possibilities) { Possibilities.new }
    let(:player1) { Player.new('p1', 'X') }
    let(:player2) { Player.new('p2', 'X') }
    subject(:new_game) { described_class.new(player1, player2, board, possibilities) }

    context 'when player performs a winning move'

    it 'returns true when board reads X X X across top row' do
    end
  end
end
