require_relative "piece"

class King < Piece
	def initialize (color,unicode)
		super
		@type = "King"
		@unicode = unicode
	end

	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if ((fromX-toX).abs == 1 && fromY-toY == 0)
			return true
		elsif (fromX-toX == 0 && (fromY-toY).abs == 1)
			return true
		elsif ((fromX-toX).abs == (fromY-toY).abs && (fromX-toX).abs == 1)
			return true
		else
			return false
		end
	end

	def movePath (from,to)
		# doesn't need a path, but still need a function to call
	end
end