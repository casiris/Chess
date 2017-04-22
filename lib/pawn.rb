class Pawn
	def isLegal (from,to,black=false)
		if (black)
			if (from.between?(8,15))
				if (to-from == 8 || to-from == 16)
					return true
				else
					return false
				end
			else						# if the pawn is anywhere but the starting position, it can only move 1 square forward
				if (to-from == 8)
					return true
				else
					return false
				end
			end
		else
			if (from.between?(48,55))
				if (from-to == 8 || from-to == 16)
					return true
				else
					return false
				end
			else
				if (from-to == 8)
					return true
				else
					return false
				end
			end
		end
	end

	def capture ()
	end
end


# need to check starting position to determine if it can move 2 spaces or just one
# need to move a white pawn and a black pawn "forward" relatively
	# so white would subtract index to go "up" the board, and black would add

# will need en passent and promotion