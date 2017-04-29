class Pawn
	def isLegal (from,to,black)
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

	def capture (from,to,black)
		if (black)
			# move pawn diagonally to capture
			if (to-from == 7 || to-from == 9)
				return true
			else
				return false
			end
		else
			if (from-to == 7 || from-to == 9)
				return true
			else
				return false
			end
		end
	end
end


# will need en passent and promotion