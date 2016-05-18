require 'spec_helper'

describe Board do
	context "an empty board" do
		before :each do
			@board = Board.new
		end

		it "can convert a location to a set of co-ordinates" do
			expect(@board.convert_location(6)).to eql([1,2])
		end

		it "can allow a token to be placed" do
			@board.place_token('O', 1)
			expect(@board.layout).to eq([['O',' ',' '],[' ',' ',' '],[' ',' ',' ']])
		end
	end

	context "with a horizontal row of O's" do
		before :all do
			@board = Board.new
			@board.place_token('O', 1)
			@board.place_token('O', 2)
			@board.place_token('O', 3)
		end

		it "finds a win for O when checking rows" do
			expect(@board.check_rows).to eql('O')
		end
		it "finds nothing when checking columns" do
			expect(@board.check_columns).to be false
		end
		it "finds nothing when checking diagonals" do
			expect(@board.check_diagonals).to be false
		end
		it "returns 'O' as the winner" do
			expect(@board.check_for_winner).to eql('O')
		end
	end

	context "with a full board" do
		before :all do
			@board = Board.new
			@board.place_token('O', 1)
			@board.place_token('X', 2)
			@board.place_token('O', 3)
			@board.place_token('X', 4)
			@board.place_token('O', 5)
			@board.place_token('X', 6)
			@board.place_token('O', 7)
			@board.place_token('X', 8)
			@board.place_token('O', 9)
		end

		it "reports that the board is full" do
			expect(@board.no_more_moves).to be true
		end
		it "allows no more moves to be played" do
			expect(@board.place_token('O', 5)).to be false
		end
	end

	context "with a new game" do
		# before :each do
 	# 		expect(Game).to receive(:gets).and_return('1')
 	# 	end

 		it "starts the game loop" do
 			Game.stub!(:game_loop) {true}
 			@game = Game.new
 			expect(@game).to receive(:game_loop).with(:no_args)
 			#game.should_receive(:game_loop)
 			#allow(Kernel).to receive(:gets) {'1'}
 		end
	end
end