class Rook
	def isLegal (from,to,board)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8
		piece = board[fromX][fromY]		# so we can know which pieces are allied and which are enemies
		path = []

		if (toY-fromY == 0)
			# vertical move
			# now check path for obstructions
			if (fromX < toX)
				for i in fromX..toX
					path << board[i][fromY]
				end
			else
				for i in toX..fromX
					path << board[i][fromY]
				end
				path.reverse!
			end

			# don't have to worry about figuring out whether to loop from to-from or from-to
			# because ultimately it's the same thing, ie, i'll check every square no matter what direction i come from
		elsif (toX-fromX == 0)
			# horizontal move, check for obstructions
			if (fromY < toY)
				for i in fromY..toY
					path << board[fromX][i]
				end
			else
				for i in toY..fromY
					path << board[fromX][i]
				end
				path.reverse!
			end
		else
			# if the change in both x and y positions are both nonzero, then that's already an illegal move 
			# because knight can only move in a straight horizontal or vertical
			return false
		end
		clearPath(path)
	end

	def clearPath (path)
		# ignore first element in path, because that is the piece we're moving
		for i in 1..path.length-2
			if (path[i] != "_")
				return false
			end
		end
		# check the final square and see if it's allied or enemy
		# if enemy, we can move there
		# i think it'd be easier if i did actually implement black/white, instead of just relying on the ascii code

		# actually, because we're checking for ally/enemy in the game loop, we don't need to do it here
		# however, it probably would be best to do it in each individual piece class eventually
		return true
	end
end