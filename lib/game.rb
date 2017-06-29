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

	def gameLoop
		activePlayer = @playerWhite
		check = false
		checkmate = false
		lastMove = @board.pieceAtIndex(59)
		prevTo = 0

		@board.display

		while (!checkmate)
			@from = getFrom(activePlayer)
			to = getTo(activePlayer)

			if (check == true)
				@board.update(@from,to)
				if (lastMove.isCheck(prevTo) == true)
					puts "That move leaves you in check. Try a different move"
					# undo the last update if the tentative move didn't get player out of check
					@board.update(to,@from)
					redo
				else
					check = false
				end
				# undo the update until we update for real at the end of gameLoop
				# otherwise it messes with getting lastMove
				@board.update(to,@from)
			end

			lastMove = @board.pieceAtIndex(@from)
			# the last piece to move. after making a legal move, check if it has put the opposite king in check
			if (lastMove.isCheck(to) == true)
				check = true
				puts "king in check"
			else
				check = false
				puts "no check"
			end

			activePlayer = switchPlayer(activePlayer)

			prevTo = to

			@board.update(@from,to)
			@board.display
		end
	end
end


# check
# if in check, have the player choose a tenative move
	# tenative move
	# get from and to
	# update the board, but don't display it
	# check for check again
	# if it doesn't get player out of check, reset the board to the state it was in before
		# could either store board in a temp variable
		# or store from/to in temp variables

# i need to check if any move would put yourself in check. ie, moving a piece that was otherwise blocking a check
# in order to do that, i should check if the king is in check after every move
# and i should do that in its own class like i was doing, but right now it doesn't work
# it does prevent the king from moving in check, but if it's in check, it prevents it from moving at all
# fix that and we should be good

# for checkmate, exapmle: black king can't make a move, check every black piece to see where they can move
# then check the threatening piece (or pieces) and see if anywhere it can move is intersected by the black pieces
# if there is an intersection, we know there's a move that can be made to get black out of check
# if thare are no intersections, that's checkmate
# the only problem i can see is a black piece intersecting the threatening piece in the wrong direction
# for instance, white rook checking black king on the north, but a black rook beside the king could intersect
# the white rook's east path, which would give a false positive

g = Game.new
g.gameLoop