require_relative "board"
require_relative "player"

class Game
	def initialize
		@board = Board.new
		@playerWhite = Player.new("White")
		@playerBlack = Player.new("Black")
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

	def switchPlayer (player)
		if (player.color == "White")
			return @playerBlack
		else
			return @playerWhite
		end
	end

	def switchKing (king)
		if (king.color == "White")
			return @kingBlack
		else
			return @kingWhite
		end
	end

	def gameLoop
		activePlayer = @playerWhite
		activeKing = @kingWhite
		check = false
		checkmate = false

		@board.display

		while (!checkmate)
			@from = getFrom(activePlayer)
			to = getTo(activePlayer)

			@board.update(@from,to)

			if (activeKing.check(activeKing.position,@board.board) == true)
				puts "That move leaves you in check. Try a different move"

				@board.update(to,@from)
				@from = getFrom(activePlayer)
				to = getTo(activePlayer)
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

			activePlayer = switchPlayer(activePlayer)
		end
	end
end

# checkmate
# apparently all i need to do is check every possible move for each piece
# generateMoves will get a list of every possible move in the piece's relevant directions
# loop through all of those, update, check for check, undo update

# probably want to check the king first. if it can move, we can stop there

g = Game.new
g.gameLoop

# check
# need to prevent king from moving if it would put itself in check
# and actually, need to prevent any move that would put self in check
# then, at the end of the turn, check for check to start the checkmate process