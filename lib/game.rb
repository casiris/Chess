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
        @enPass = nil
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
				# handle en passant here, before the player decides where to move the pawn
				if (piece.type == "Pawn")
					if (@enPass != nil)
						fromX = coord / 8
						fromY = coord % 8
						epX = @enPass / 8
						epY = @enPass % 8

						if ((fromX-epX).abs == 1 && (fromY-epY).abs == 1)
							puts "en pass applicable"
							# need to add ep square as an array
							ep = []
							ep << @enPass
							piece.legalMoves << ep
						end
					end
				end
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

			piece = @board.pieceAtIndex(@from)

			# if the king is trying to casle, call its castle function
			if (piece.type == "King")
				if ((@from-coord).abs == 2)
					if (piece.castle(@from,coord,@board.board) == true)
						checkInput = true
						# need to move rook -1 and king +3 (return as coord)
						@board.update(@from+3,@from+1)
						return coord
					else
						puts "Can't castle"
						@from = getFrom(player)
					end
				elsif ((@from-coord).abs == 3)
					if (piece.castle(@from,coord,@board.board) == true)
						checkInput = true
						# need to move rook -1 and king +3
						@board.update(@from-4,@from-2)
						return coord
					else
						puts "Can't castle"
						@from = getFrom(player)
					end
				else
					# not trying to castle, just handle input for king normally
					if (piece.isLegal(coord,@board.board) == true)
						checkInput = true
						return coord
					else
						puts "Can't move that piece there. Pick a different piece"
						@from = getFrom(player)
					end
				end
			elsif (piece.type == "Pawn")
				# if pawn is capturing en passant square, we need to remove the appropriate pawn
				# loop through opposite piece array and find/delete pawn with the same ep square
				if (coord == @enPass)
					if (@player.color == "Black")
						@board.whitePieces.each do |i|
							if (i.type == "Pawn")
								if (i.enPassant == coord)
									@board.whitePieces.delete(i)
								end
							end
						end
					else
						@board.blackPieces.each do |i|
							if (i.type == "Pawn")
								if (i.enPassant == coord)
									@board.blackPieces.delete(i)
								end
							end
						end
					end
				end
				if (piece.isLegal(coord,@board.board) == true)
					checkInput = true
					return coord
				else
					puts "Can't move that piece there. Pick a different piece"
					@from = getFrom(player)
				end
			# call the piece's isLegal function, give it the from/to, and determine whether the player can make that move
			# if they can, return coord (as to)
			# if they can't, ask them to move a different piece and call getFrom again
			elsif (piece.isLegal(coord,@board.board) == true)
				checkInput = true
				return coord
			else
				puts "Can't move that piece there. Pick a different piece"
				@from = getFrom(player)
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

	def isCheckmate(currentPlayer,currentKing)
		if (currentPlayer.color == "White")
			@board.whitePieces.each do |i|
				# need a variable for position, because the pieces update their position when the board updates
				piecePosition = i.position
				i.generateMoves(@board.board)

				i.legalMoves.each do |j|
					j.each do |k|
						# get a different copy of the board for each possible move
						tempBoard = @board.tempUpdate(@board.board,piecePosition,k)

						if (i.type == "King")
							# king wasn't being put in check correctly because its position wasn't updating for the temp move
							currentKing.position = k
						end
						if (currentKing.check(tempBoard) == false)
							return false
						end
					end
					# reset king to its original position
					if (i.type == "King")
						currentKing.position = piecePosition
					end
				end
			end
			# if we get through the whole array and king was always in check, it's checkmate
			return true
		else
			@board.blackPieces.each do |i|
				piecePosition = i.position
				i.generateMoves(@board.board)

				i.legalMoves.each do |j|
					j.each do |k|
						tempBoard = @board.tempUpdate(@board.board,piecePosition,k)

						if (i.type == "King")
							currentKing.position = k
						end
						if (currentKing.check(tempBoard) == false)
							return false
						end
					end
					if (i.type == "King")
						currentKing.position = piecePosition
					end
				end
			end
			return true
		end
	end

	def gameLoop
		currentMove = nil
		activeKing = @kingWhite
		checkmate = false

		@board.display

		while (!checkmate)
			@from = getFrom(@player)
			to = getTo(@player)

			@board.update(@from,to)

			# prevent moves that put yourself in check
			if (activeKing.check(@board.board) == true)
				puts "That move leaves you in check. Try a different move"
				# undo update if the move is illegal
				@board.update(to,@from)
				redo
			else
				@board.update(to,@from)
			end

			# update for real once we have a valid from/to
			@board.update(@from,to)

			# this will only be not nil from the second turn onwards
			# so at this point, before setting currentMove, this basically acts as the previous move
			# so we'll reset the pawn's en passant square here, after we've gotten a valid move and the ep square is no longer valid
			if (currentMove != nil)
				if (currentMove.type == "Pawn")
					currentMove.enPassant = nil
				end
			end

			# get the current piece to move. if it's a pawn, check for en passant and promotion
			currentMove = @board.pieceAtIndex(to)
			if (currentMove.type == "Pawn")
				promotion = currentMove.checkPromotion
				if (promotion != nil)
					@board.pawnPromotion(promotion.downcase,currentMove.position)
				end

				# get en passant if applicable
				if ((@from-to).abs == 16)
					@enPass = currentMove.getEnPassant
				# if player moves pawn but doesn't move two squares, reset en passant square
				else
					@enPass = nil
				end
			# if player moves a piece besides a pawn, reset en passant square
			elsif (currentMove.type != "Pawn")
				@enPass = nil
			end

			# set hasMoved here because it's the surest way to know a piece has moved, once a valid input has gotten and the board updated
			currentMove.hasMoved = true

			@player.switchPlayer
			activeKing = switchKing(activeKing)

			# if king is in check, then check for checkmate
			if (activeKing.check(@board.board) == true)
				puts "#{activeKing.color} King in check"
				checkmate = isCheckmate(@player,activeKing)
			end

			@board.display
		end

		@player.switchPlayer
		puts "#{activeKing.color} King in checkmate. Player #{@player.color} wins"
	end
end

g = Game.new
g.gameLoop