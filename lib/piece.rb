class Piece
	attr_reader :color, :type, :unicode, :path

	def initialize (color,unicode)
		@color = color
		@path = []
		@board
	end

	def toString
		"#{@color} #{@type}"
	end

	def isLegal (from,to,board)
		@board = board

		# check to make sure moved piece can move to "to"
		if (validateMove(from,to) == false)
			return false
		end

		# need to clear the path before we use it to make sure there aren't leftover things from when that piece last moved
		@path = []

		# this will call each individual piece's movePath functions, even though it doesn't exist in Piece
		movePath(from,to)

		# need to loop through path to find obsructions
		# but only up to the last element, because it's treated differently
		for i in 0..@path.length-2
			if @path[i] != nil
				return false
			end
		end

		return checkLastTileInPath(@path)
	end

	def checkLastTileInPath(path)
		if (path[-1] != nil)
			if (path[-1].color != self.color)
				return true
			else
				return false
			end
		else
			return true
		end
	end

	# [-1,0]
	def north (fromX,fromY,toX)
		for i in toX..fromX-1
			@path << @board[i][fromY]
		end
		@path.reverse!
	end

	# [1,0]
	def south (fromX,fromY,toX)
		for i in fromX+1..toX
			@path << @board[i][fromY]
		end
	end

	# [0,1]
	def east (fromX,fromY,toY)
		for i in fromY+1..toY
			@path << @board[fromX][i]
		end
	end

	# [0,-1]
	def west (fromX,fromY,toY)
		for i in toY..fromY-1
			@path << @board[fromX][i]
		end
		@path.reverse!
	end

	# [-1,1]
	def northEast (fromX,fromY,toX,toY)
		x = fromX-1
		y = fromY+1

		while (x >= toX && y <= toY)
			@path << @board[x][y]
			x -= 1
			y += 1
		end
	end

	# [-1,-1]
	def northWest (fromX,fromY,toX,toY)
		x = fromX-1
		y = fromY-1

		while (x >= toX && y >= toY)
			@path << @board[x][y]
			x -= 1
			y -= 1
		end
	end

	# [1,1]
	def southEast (fromX,fromY,toX,toY)
		x = fromX+1
		y = fromY+1

		while (x <= 7 && y <= 7)
			@path << @board[x][y]
			x += 1
			y += 1
		end
	end

	# [1,-1]
	def southWest (fromX,fromY,toX,toY)
		x = fromX+1
		y = fromY-1

		while (x <= 7 && y >= 0)
			@path << @board[x][y]
			x += 1
			y -= 1
		end
	end
end