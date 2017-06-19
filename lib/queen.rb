require_relative "piece"

class Queen < Piece
	def initialize (color,unicode)
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
				north(fromX,fromY,toX)
			elsif (fromX < toX)
				south(fromX,fromY,toX)
			end
			if (fromY < toY)
				east(fromX,fromY,toY)
			elsif (fromY > toY)
				west(fromX,fromY,toY)
			end
		else
			if (dirX < 0 && dirY < 0)
				northWest(fromX,fromY,toX,toY)
			elsif (dirX < 0 && dirY > 0)
				northEast(fromX,fromY,toX,toY)
			elsif (dirY > 0 && dirY < 0)
				southWest(fromX,fromY,toX,toY)
			elsif (dirY > 0 && dirY > 0)
				southEast(fromX,fromY,toX,toY)
			end
		end
	end

	def kingPath (pos)
		posX = pos / 8
		posY = pos % 8

		north(posX,posY,0)
		south(posX,posY,7)
		east(posX,posY,7)
		west(posX,posY,0)
		northWest(posX,posY,0,0)
		northEast(posX,posY,0,7)
		southWest(posX,posY,7,0)
		southEast(posX,posY,7,7)
	end
end

# this is just an amalgamation of rook and bishop