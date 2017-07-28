require_relative "../piece"

class Pawn < Piece
	def initialize (color,unicode,pos)
		super
		@type = "Pawn"
		@unicode = unicode
		@enPassant = false
	end

	def validateMove (from,to)
		if ((from % 8) - (to % 8) == 0)		# if no change in y, we know we're only moving up or down
			return moveForward(from,to)
		else
			return capture(from,to)
		end
	end

	def moveForward (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if (@board[toX][toY] == nil)
			if (self.hasMoved == false)
				if (self.color == "Black")
					if (toX-fromX == 1)
						return true
					elsif (toX-fromX == 2)
						@enPassant = true
						return true
					end
				elsif (self.color == "White")
					if (toX-fromX == -1)
						return true
					elsif (toX-fromX == -2)
						@enPassant = true
						return true
					end
				else
					return false
				end
			else
				if (self.color == "Black" && toX-fromX == 1)
					return true
				elsif (self.color == "White" && toX-fromX == -1)
					return true
				else
					return false
				end
			end
		else
			return false
		end
	end

	def capture (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		# it's a mess but it works
		if (@board[toX][toY] != nil)
			if (@board[toX][toY].color != self.color)
				if (self.color == "Black")
					if (toX-fromX == 1 && (toY-fromY).abs == 1)
						return true
					else 
						return false
					end
				else
					if (toX-fromX == -1 && (toY-fromY).abs == 1)
						return true
					else
						return false
					end
				end
			else
				return false
			end
		else
			return false
		end
	end

	def movePath (from,to)
		# doesn't need a path, but still needs a function to call
		@path = [[]]
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8

		if (self.color == "Black")
			if (posX+1 <= 7)
				southMoves(posX,posY,posX+1)
			end
			if (posX+1 <= 7 && posY+1 <= 7)
				southEastMoves(posX,posY,posX+1,posY+1)
			end
			if (posX+1 <= 7 && posY >= 0)
				southWestMoves(posX,posY,posX+1,posY-1)
			end
		else
			if (posX-1 >= 0)
				northMoves(posX,posY,posX-1)
			end
			if (posX-1 >= 0 && posY+1 <= 7)
				northEastMoves(posX,posY,posX-1,posY+1)
			end
			if (posX-1 >= 0 && posY-1 >= 0)
				northWestMoves(posX,posY,posX-1,posY-1)
			end
		end

		# removes emtpy arrays that exist thanks to movePath
		@path.delete([])
	end

	def checkPromotion
		pieces = ["rook","knight","bishop","queen"]

		if (self.color == "Black")
			# get x coord of position, see if pawn has made it to the other side
			if (self.position/8 == 7)
				puts "What piece do you want to promote pawn to?"
				promotion = gets.chomp

				while !(pieces.include?(promotion.downcase))
					puts "Not a valid piece. Try again"
					promotion = gets.chomp
				end
				return promotion
			end
		else
			if (self.position/8 == 0)
				puts "What piece do you want to promote pawn to?"
				promotion = gets.chomp

				while !(pieces.include?(promotion.downcase))
					puts "Not a valid piece. Try again"
					promotion = gets.chomp
				end
				return promotion
			end
		end
		return nil
	end

	def getEnPassantSquare
		if (@enPassant == true)
			if (self.color == "Black")
				# don't need to worry about bounds checking, since enPassant will only be true on the intial move, and +-10 won't be offboard
				return self.position-8
			else
				return self.position+8
			end
		else
			return nil
		end
	end
end

# en passant
# can only capture en passant on the very next turn, and yes, it can only be opposing pawns

# have a function that returns true when a pawn moves 2 squares, and have game check for that in the game loop
# get lastMove, and if it's a pawn (and enPassant is true), then see if that pawn can capture en passant
# which means that the en passant square would be on the same horizontal as lastMove