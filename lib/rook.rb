require_relative "piece"

class Rook < Piece
	def initialize (color,unicode)
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
		# later, when checking for the king, i can go the entire distance in that direction
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
	end
end

# rook can move anywhere, as long as the cardinal directions are clear
# for instance, if moved out into the open middle, it can then move diagonally because there's no obstructions in the immediate NSEW
# and bishop has been able to move wherever as well
# so, movement isn't properly restrained