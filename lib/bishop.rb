class Bishop
	def isLegal (from,to,board)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		# find the direction (+/-1 for each coordinate)
		dirX = fromX > toX ? -1 : 1
		dirY = fromY > toY ? -1 : 1
		path = []

		if ((toX-fromX).abs == (toY-fromY).abs)
			for i in 0..(toX-fromX).abs
				path << board[fromX+i*dirX][fromY+i*dirY]
			end
			checkPath(path)
			#return true
		end
		#return false
	end

	# same checkPath function as from rook, but how to add pieces to the path is different
	def checkPath (path)
		for i in 1..path.length-2
			if (path[i] != "_")
				return false
			end
		end
		return true
	end
end

# bishop can move [1,1], [1,-1], [-1, 1], or [-1,-1]
# probably a good idea to eventually make use of an array with possible moves for every piece