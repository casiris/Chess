require_relative "../piece"

class Pawn < Piece

	def initialize (color,unicode,pos)
		super
		@type = "Pawn"
		@unicode = unicode
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

		if (@board[toX][fromX] == nil)
			if (fromX == 1 || fromX == 6) 		# if pawns are in respective home rows, ie, haven't yet moved
				if (self.color == "Black" && (toX-fromX == 1 || toX-fromX == 2))
					return true
				elsif (self.color == "White" && (toX-fromX == -1 || toX-fromX == -2))
					return true
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

	def generateMoves (pos)
		posX = pos / 8
		posY = pos % 8

		if (self.color == "Black")
			southEastMoves(posX,posY,posX+1,posY+1)
			southWestMoves(posX,posY,posX+1,posY-1)
		else
			northEastMoves(posX,posY,posX-1,posY+1)
			northWestMoves(posX,posY,posX-1,posY-1)
		end
	end
end