require_relative "../piece"

class Knight < Piece
	def initialize (color,unicode)
		super
		@type = "Knight"
		@unicode = unicode
	end

	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if (@board[toX][toY] == nil || @board[toX][toY].color != self.color)
			# can only move +/-[1,2] or +/-[2,1]
			if ((toX-fromX).abs == 1 && (toY-fromY).abs == 2) || ((toX-fromX).abs == 2 && (toY-fromY).abs == 1)
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def movePath (from,to)
		# doesn't need path
	end

	def kingPath (pos)
		knightPath(pos)
	end
end