require_relative "../piece"

class Bishop < Piece
	def initialize (color,unicode,pos)
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

		if ((toX-fromX).abs == (toY-fromY).abs)
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
			northWestMoves(fromX,fromY,toX,toY)
		elsif (dirX < 0 && dirY > 0)
			northEastMoves(fromX,fromY,toX,toY)
		elsif (dirX > 0 && dirY < 0)
			southWestMoves(fromX,fromY,toX,toY)
		elsif (dirX > 0 && dirY > 0)
			southEastMoves(fromX,fromY,toX,toY)
		end
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8

		northWestMoves(posX,posY,0,0)
		northEastMoves(posX,posY,0,7)
		southWestMoves(posX,posY,7,0)
		southEastMoves(posX,posY,7,7)

		filterMoves(board)
	end
end