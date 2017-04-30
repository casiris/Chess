class Rook
	def isLegal (from,to)
		dist = (from-to).abs
		if (dist % 8 == 0 || dist < 8)
			return true
		else
			return false
		end
	end
end

# multiples of +-8 vertically or up to 8 horizontally

# currently, rooks can move through other pieces as long as the destination is empty