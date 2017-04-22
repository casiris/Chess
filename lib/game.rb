require_relative "board"
require_relative "pawn"

class Game
	attr_accessor :board, :coordinate

	def initialize
		@board = Board.new
		@pawn = Pawn.new
		@coordinate = [ "a1","b1","c1","d1","e1","f1","g1","h1",
						"a2","b2","c2","d2","e2","f2","g2","h2",
						"a3","b3","c3","d3","e3","f3","g3","h3",
						"a4","b4","c4","d4","e4","f4","g4","h4",
						"a5","b5","c5","d5","e5","f5","g5","h5",
						"a6","b6","c6","d6","e6","f6","g6","h6",
						"a7","b7","c7","d7","e7","f7","g7","h7",
						"a8","b8","c8","d8","e8","f8","g8","h8"]
	end

	def getInput
		input = gets.chomp

		while (validateInput(input) == false)
			puts "Invalid positon, try somewhere else"
			input = gets.chomp
		end
		return validateInput(input)
	end

	def convertRankFile (coord)
		if (@coordinate.include? coord.downcase)
			return @coordinate.index(coord.downcase)
		else
			return -1
		end
	end

	# need to make sure it's in the format "a1" or whatever, not a number
	def validateInput (input)
		index = convertRankFile(input.to_s)

		if (index.between?(0,63))
			return index
		else
			return false
		end
	end

	def movePiece (from,to,piece)
		case piece
		when "p"
			@pawn.isLegal(from,to,true)
		when "P"
			@pawn.isLegal(from,to,false)
		else
		end
	end

	def gameLoop
		@board.display
		win = false

		while (win == false)
			puts "Enter a piece to move"
			from = getInput

			while (@board.pieceAtIndex(from) == "_")
				puts "No piece at that position, try again"
				from = getInput
			end
			piece = @board.pieceAtIndex(from)

			puts "Enter where to move"
			to = getInput

			while (movePiece(from,to,piece) == false)
				puts "Can't move that piece there, try again"
				to = getInput
			end

			@board.updateBoard(from,to)
			@board.display
		end
	end
end

g = Game.new
g.gameLoop

# get input (what piece do you want to move?)
	# validate it
		# convert the rank and file to a number, return it
	# check board at that index
		# if it's empty (_), print out error and ask for another position
		# if it isn't, return that piece
# get second input (where to move to)
	# validate and convert the rank/file
	# call respective function for whatever piece was returned prior
		# check "to" for legality
			# if it isn't legal, ask for input again
			# if it is, update the board
			# switch player
<<<<<<< HEAD


# for check/mate, and i guess in the future for ai, i'll need a function to check what threatens a given square
# if i'm not mistaken, i'd just have to check in all 8 directions, and see if there's any applicable piece
# in that direction, ie, is there anything on any diagonal, and if so, is it a pawn 1 space away, or a bishop/queen
# any distance away, etc
# so, kinda like checking for connect four
=======
>>>>>>> 1d0c53e93e789bc8dcc88e5a79d0d3f6418fef56
