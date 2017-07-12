require_relative "../piece"

class Queen < Piece
	def initialize (color,unicode,pos)
		super
		@type = "Queen"
		@unicode = unicode
		@diagonal = false
	end

	# constrain to cardinal directions or diagonals
	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if (toX-fromX != 0 && toY-fromY == 0)
			@diagonal = false
			return true
		elsif (toX-fromX == 0 && toY-fromY != 0)
			@diagonal = false
			return true
		elsif ((toX-fromX).abs == (toY-fromY).abs)
			@diagonal = true
			return true
		else
			return false
		end		
	end

	def movePath (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8
		dirX = toX - fromX
		dirY = toY - fromY

		if (@diagonal == false)
			if (fromX > toX)
				northMoves(fromX,fromY,toX)
			elsif (fromX < toX)
				southMoves(fromX,fromY,toX)
			end
			if (fromY < toY)
				eastMoves(fromX,fromY,toY)
			elsif (fromY > toY)
				westMoves(fromX,fromY,toY)
			end
		else
			if (dirX < 0 && dirY < 0)
				northWestMoves(fromX,fromY,toX,toY)
			elsif (dirX < 0 && dirY > 0)
				northEastMoves(fromX,fromY,toX,toY)
			elsif (dirY > 0 && dirY < 0)
				southWestMoves(fromX,fromY,toX,toY)
			elsif (dirY > 0 && dirY > 0)
				southEastMoves(fromX,fromY,toX,toY)
			end
		end
	end

	def generateMoves (pos)
		posX = pos / 8
		posY = pos % 8

		northMoves(posX,posY,0)
		southMoves(posX,posY,7)
		eastMoves(posX,posY,7)
		westMoves(posX,posY,0)
		northWestMoves(posX,posY,0,0)
		northEastMoves(posX,posY,0,7)
		southWestMoves(posX,posY,7,0)
		southEastMoves(posX,posY,7,7)
	end
end

# this is just an amalgamation of rook and bishop