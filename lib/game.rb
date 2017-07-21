require_relative "board"
require_relative "player"

class Game
	def initialize
		@board = Board.new
		@player = Player.new("White")
		@kingWhite = @board.pieceAtIndex(60)
		@kingBlack = @board.pieceAtIndex(4)
		@coordinate = [ "a1","b1","c1","d1","e1","f1","g1","h1",
                        "a2","b2","c2","d2","e2","f2","g2","h2",
                        "a3","b3","c3","d3","e3","f3","g3","h3",
                        "a4","b4","c4","d4","e4","f4","g4","h4",
                        "a5","b5","c5","d5","e5","f5","g5","h5",
                        "a6","b6","c6","d6","e6","f6","g6","h6",
                        "a7","b7","c7","d7","e7","f7","g7","h7",
                        "a8","b8","c8","d8","e8","f8","g8","h8"]
        @from 		# needs to be global because of the way i handle input in getTo
	end

	def getFrom (player)
		checkInput = true
		while (checkInput)
			puts "Player #{player.color}, enter a piece to move"
			input = gets.chomp

			# get index of given rank/file
			if (@coordinate.include?(input.downcase))
				coord = @coordinate.index(input.downcase)
			else
				puts "Outside of coordinate range"
				redo		# start loop over so we don't continue with an invalid/nil position
			end

			piece = @board.pieceAtIndex(coord)

			if (piece != nil)
				if (piece.color == player.color)
					checkInput = false
					return coord
				else
					puts "You don't control that piece"
				end
			else
				puts "No piece at that position"
			end
		end
	end

	def getTo (player)
		checkInput = true
		while (checkInput)
			puts "Pick a place to move to"
			input = gets.chomp

			if (@coordinate.include?(input.downcase))
				coord = @coordinate.index(input.downcase)
			else
				puts "Outside of coordinate range"
				redo
			end

			# then call the piece's isLegal function, give it the from/to, and determine whether the player can make that move
			piece = @board.pieceAtIndex(@from)
			# if they can, return coord (as to)
			# if they can't, ask them to move a different piece and call getFrom again
			if (piece.isLegal(@from,coord,@board.board) == true)
				checkInput = true
				return coord
			else
				puts "Can't move that piece there. Pick a different piece"
				@from = getFrom (player)
			end
		end
	end

	def switchKing (king)
		if (king.color == "White")
			return @kingBlack
		else
			return @kingWhite
		end
	end

	# instead of filtering out invalid moves, it'd be easier to just call each piece's isLegal function
	# if the move isn't legal, we can't move there, so we can go to the next possible move
	# also, for sliding pieces, if one move is invalid, then the rest of that direction is also invalid, so we can skip to the next direction
	# for non-sliding pieces, it will work the same, except they only have 1 move in any direction array, so no need for a special case
	# after all that, if isLegal is true, then we can update, check for check, and do all that

	# loop through appropriate piece array, generate what moves each piece can make, add legal moves to an array
	def findLegalMoves (currentKing)
		legalMoves = []
		if (@player.color == "White")
			for i in 0..@board.whitePieces.length-1
				@board.whitePieces[i].generateMoves(@board.board)

				@board.whitePieces[i].path.each do |j|
					j.each do |k|
						if (@board.whitePieces[i].isLegal(@board.whitePieces[i].position,k,@board.board))
							legalMoves << k
						else
							# if a move isn't legal in a certain direction, we can break and go to the next direction
							break							
						end
					end
				end
			end 
		else
			for i in 0..@board.blackPieces.length-1
				@board.blackPieces[i].generateMoves(@board.board)

				@board.blackPieces[i].path.each do |j|
					j.each do |k|
						if (@board.blackPieces[i].isLegal(@board.blackPieces[i].position,k,@board.board))
							legalMoves << k
						else
							break							
						end
					end
				end
			end 
		end
	end

	def isCheckmate(currentKing,legalMoves)
		# the problem with separating findLegalMovees and isCheckmate is that the legalMoves array is just an array with no refernce point
		# i don't know which pieces are able to move to whatever position in the array

		# i guess i could have separate arrays within legalMoves for each piece, like i'm doing with generateMoves
		# and then it would easily line up with the piece arrays
	end

	def gameLoop
		activeKing = @kingWhite
		check = false
		checkmate = false

		@board.display

		while (!checkmate)
			@from = getFrom(@player)
			to = getTo(@player)

			@board.update(@from,to)

			if (activeKing.check(activeKing.position,@board.board) == true)
				puts "That move leaves you in check. Try a different move"

				@board.update(to,@from)
				@from = getFrom(@player)
				to = getTo(@player)
			else
				@board.update(to,@from)
				check = false
			end

			# end of turn. update and display board
			@board.update(@from,to)
			@board.display

			# get last piece to move and see if it has put the king in check
			lastMove = @board.pieceAtIndex(to)
			activeKing = switchKing(activeKing)

			if (activeKing.check(activeKing.position,@board.board) == true)
				puts "#{activeKing.color} King in check"
				check = true
			end

			legalMoves = findLegalMoves
			isCheckmate(activeKing,legalMoves)

			@player.switchPlayer
		end
	end
end

# checkmate
# apparently all i need to do is check every possible move for each piece (the current player's array of pieces)
	# might want to update player class to include that, to make it easier
# generateMoves will get a list of every possible move in the piece's relevant directions (as an index on the board)
	# currently gets every square in applicable directions. need to filter out squares that are occpuied by your own pieces
# then loop through path, update, check for check, then undo update

# probably want to check the king first. if it can move, we can stop there
# actually it doesn't matter. if any piece can move, we can stop

g = Game.new
g.gameLoop

# check
# need to prevent king from moving if it would put itself in check
# and actually, need to prevent any move that would put self in check
# then, at the end of the turn, check for check to start the checkmate process