require_relative "../piece"

class Rook < Piece
	def initialize (color,unicode,pos)
		super
		@type = "Rook"
		@unicode = unicode
	end

	# constrain rook to cardinal directions only
	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if (toX-fromX != 0 && toY-fromY == 0)
			return true
		elsif (toX-fromX == 0 && toY-fromY != 0)
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

		# only want to call the direction "to" is in
		# also want the loop bounds to only be from from-to, instead of the entire length of the board from the current position
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
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8

		northMoves(posX,posY,0)
		southMoves(posX,posY,7)
		eastMoves(posX,posY,7)
		westMoves(posX,posY,0)

		@path.delete([])
	end
end