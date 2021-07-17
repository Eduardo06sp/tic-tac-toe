# frozen_string_literal: true

require_relative '../tic_tac_toe'
require_relative '../game_board'
require_relative '../possibilities'

describe TicTacToe do
  describe '#winner?' do
    let(:board) { GameBoard.new }
    let(:possibilities) { Possibilities.new }
    subject(:new_game) { described_class.new('p1', 'p2', board, possibilities) }

    context 'when player performs a winning move'

    it 'returns true when board reads X X X across top row' do
    end
  end
end
