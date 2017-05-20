class Queen
	def isLegal (from,to,board)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		dirX = fromX > toX ? -1 : 1
		dirY = fromY > toY ? -1 : 1
		path = []

		# if +/-1 
		if ((toX-fromX).abs == (toY-fromY).abs)
			for i in 0..(toX-fromX).abs
				path << board[fromX+i*dirX][fromY+i*dirY]
			end
			#return true
		# no change in x
		elsif (toY-fromY == 0)
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
		# no change in y
		elsif (toX-fromX == 0)
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
			return false
		end
		checkPath(path)
	end

	def checkPath (path)
		for i in 1..path.length-2
			if (path[i] != "_")
				return false
			end
		end
		return true
	end
end


# this works, but i basically just copied the relevant rook and bishop parts and combines them