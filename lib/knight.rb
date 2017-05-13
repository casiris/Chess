class Knight
	def isLegal (from,to)
		# can only move +-1/+-2 or +-2/+-1
		# so if change in x is 1, then change in y has to be 2, or vice versa
		# if it's anything else, knight can't move there
		fromX = from / 8
		fromY =  from % 8
		toX = to / 8
		toY = to % 8

		if (((toX-fromX).abs == 1 && (toY-fromY).abs == 2) || ((toX-fromX).abs == 2 && (toY-fromY).abs == 1))
			return true
		end
		return false
	end
end