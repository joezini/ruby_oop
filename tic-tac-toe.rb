class Game
	# game loop, asks board for output to print and players for turns
	def initialize
		puts "Welcome to the game!"
		@player_o = Player.new('O')
		@next_player = @player_o
		@player_x = Player.new('X')
		@board = Board.new
		game_loop
	end
	# asks player for move, asks board to play it, goes back to player if invalid

	def game_loop
		until @board.check_for_winner || @board.no_more_moves
			puts "Player #{@next_player.token}, it's your turn."
			puts @board
			play_legal_location
			switch_player
		end
		puts @board
		puts "Game over!"
		if @board.check_for_winner
			puts "#{@board.check_for_winner} won"
		else
			puts "It's a tie"
		end
	end

	def play_legal_location
		valid_input = false
		legal_move = false
		until valid_input && legal_move
			puts "Please enter a valid move from 1-9:"
			input = gets.chomp
			if (1..9).include?(input.to_i)
				valid_input = true
				if @board.place_token(@next_player.token, input.to_i)
					legal_move = true
				end
			end
		end
	end

	def switch_player
		if @next_player == @player_o
			@next_player = @player_x
		else
			@next_player = @player_o
		end
	end
	# asks board if anyone has won and ends game
end

class Board
	# stores board
	def initialize
		@layout = [[' ',' ',' '],
				   [' ',' ',' '],
				   [' ',' ',' ']]
	end

	# implements print to console
	def to_s
		%Q(
			#{@layout[0][0]}|#{@layout[0][1]}|#{@layout[0][2]}
			-+-+-
			#{@layout[1][0]}|#{@layout[1][1]}|#{@layout[1][2]}
			-+-+-
			#{@layout[2][0]}|#{@layout[2][1]}|#{@layout[2][2]}
			)
	end
		
	def place_token(token, unconverted_location)
		location = []
		location[0], location[1] = convert_location(unconverted_location)
		if @layout[location[0]][location[1]] == ' '
			@layout[location[0]][location[1]] = token
			true
		else
			false
		end
	end

	def convert_location(x)
		if (1..3).include?(x)
			[0, x - 1]
		elsif (4..6).include?(x)
			[1, x - 4]
		else
			[2, x - 7]
		end
	end

	# checks for winner
	def check_for_winner
		if check_rows
			check_rows
		elsif check_columns
			check_columns
		elsif check_diagonals
			check_diagonals
		else
			false
		end
	end

	def check_rows
		winner = false
		(0..2).each do |i|
			row_winner = check_triplet(@layout[i][0], @layout[i][1], @layout[i][2])
			if row_winner
				winner = row_winner
				break
			end
		end
		winner
	end

	def check_columns
		winner = false
		(0..2).each do |i|
			column_winner = check_triplet(@layout[0][i], @layout[1][i], @layout[2][i])
			if column_winner
				winner = column_winner
				break
			end
		end
		winner
	end

	def check_diagonals
		winner = false
		diag_1_winner = check_triplet(@layout[0][0], @layout[1][1], @layout[2][2])
		diag_2_winner = check_triplet(@layout[0][2], @layout[1][1], @layout[2][0])
		if diag_1_winner
			winner = diag_1_winner
		elsif diag_2_winner
			winner = diag_2_winner
		end
		winner
	end

	def check_triplet(a,b,c)
		if a == b and a == c and a != ' '
			a
		else
			false
		end
	end

	def no_more_moves
		blanks = false
		@layout.each do |row|
			row.each do |el|
				blanks = true if el == ' '
			end
		end
		!blanks
	end

end

class Player
	attr_reader :token

	# is O or X
	def initialize(token)
		@token = token
	end

	# asks for moves on CL and passes them to game (or would board be better?)
end

my_game = Game.new