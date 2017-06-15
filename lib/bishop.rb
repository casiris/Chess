require_relative "piece"

class Bishop < Piece
	def initialize (color,unicode)
		super
		@type = "Bishop"
		@unicode = unicode
	end


	# contrain bishop to diagonals only
	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if (toX-fromX.abs == toY-fromY.abs)
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

# bishop can move [1,1], [1,-1], [-1, 1], or [-1,-1]
# probably a good idea to eventually make use of an array with possible moves for every piece