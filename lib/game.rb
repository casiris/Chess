require_relative "board"
require_relative "player"

class Game
	def initialize
		@board = Board.new
		@playerWhite = Player.new("White")
		@playerBlack = Player.new("Black")
		@coordinate = [ "a1","b1","c1","d1","e1","f1","g1","h1",
                        "a2","b2","c2","d2","e2","f2","g2","h2",
                        "a3","b3","c3","d3","e3","f3","g3","h3",
                        "a4","b4","c4","d4","e4","f4","g4","h4",
                        "a5","b5","c5","d5","e5","f5","g5","h5",
                        "a6","b6","c6","d6","e6","f6","g6","h6",
                        "a7","b7","c7","d7","e7","f7","g7","h7",
                        "a8","b8","c8","d8","e8","f8","g8","h8"]
	end

	def getFrom (player)
		b = true
		while (b)
			puts "Player #{player.color}, enter a piece to move"
			input = gets.chomp

			if (@coordinate.include?(input.downcase))
				coord = @coordinate.index(input.downcase)
			else
				puts "outside of coordinate range"
			end

			piece = @board.pieceAtIndex(coord/8,coord%8)

			if (piece != nil)
				if (piece.color == player.color)			# for some reason this is still checked even when piece is null
					puts "yay"
					b = false
				else
					puts "not your piece"
				end
			else
				puts "No piece at that position"
			end
		end
	end
end


# need to loop asking for input and validating it until a valid input is given
# something like puts "Enter a piece to move as a coordinate"
	# needs to check if there is a piece there, and if that piece belongs to the current player

p = Player.new("White")
g = Game.new
g.getFrom(p)