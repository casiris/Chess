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
		@path = [[]]

		# this will call each individual piece's movePath functions, even though it doesn't exist in Piece
		 movePath(from,to)

		# need to loop through path to find obsructions
		# but only up to the last element, because it's treated differently
		# also, only need to check first array in path, because there's only one array when checking movement
		for i in 0..@path[0].length-2
			if (@path[0][i] != nil)
				return false
			end
		end

		return checkLastTileInPath(@path)
	end

	# loop through each array in the outer array
	# if there's an obstruction, move onto the next array
	# if you run into the opposite king with no obstructions, it's check
	# if you go through every array and don't find the king, no check
	def isCheck (pos)
		@path = []
		kingPath(pos)

		# check path for opposite king
		for i in 0..@path.length-1
			for j in 0..@path[i].length-1
				if (@path[i][j] != nil)
					if (@path[i][j].color != self.color && @path[i][j].type == "King")
						return true
					end
				end
			end
		end
		return false
	end

	def checkLastTileInPath(path)
		if (path[0][-1] != nil)
			if (path[0][-1].color != self.color)
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
		n = []

		for i in toX..fromX-1
			n << @board[i][fromY]
		end

		n.reverse!
		@path << n
	end

	# [1,0]
	def south (fromX,fromY,toX)
		s = []

		for i in fromX+1..toX
			s << @board[i][fromY]
		end

		@path << s
	end

	# [0,1]
	def east (fromX,fromY,toY)
		e = []

		for i in fromY+1..toY
			e << @board[fromX][i]
		end

		@path << e
	end

	# [0,-1]
	def west (fromX,fromY,toY)
		w = []

		for i in toY..fromY-1
			w << @board[fromX][i]
		end

		w.reverse!
		@path << w
	end

	# [-1,1]
	def northEast (fromX,fromY,toX,toY)
		ne = []
		x = fromX-1
		y = fromY+1

		while (x >= toX && y <= toY)
			ne << @board[x][y]
			x -= 1
			y += 1
		end

		@path << ne
	end

	# [-1,-1]
	def northWest (fromX,fromY,toX,toY)
		nw = []
		x = fromX-1
		y = fromY-1

		while (x >= toX && y >= toY)
			nw << @board[x][y]
			x -= 1
			y -= 1
		end

		@path << nw
	end

	# [1,1]
	def southEast (fromX,fromY,toX,toY)
		se = []
		x = fromX+1
		y = fromY+1

		while (x <= toX && y <= toY)
			se << @board[x][y]
			x += 1
			y += 1
		end

		@path << se
	end

	# [1,-1]
	def southWest (fromX,fromY,toX,toY)
		sw = []
		x = fromX+1
		y = fromY-1

		while (x <= toX && y >= toY)
			sw << @board[x][y]
			x += 1
			y -= 1
		end

		@path << sw
	end

	def knightPath (pos)
		kp = []
		posX = pos / 8
		posY = pos % 8

		# need to make sure we don't go out of bounds
		if (posX+1 <= 7 && posY+2 <= 7)
			kp << @board[posX+1][posY+2]
		end
		if (posX+1 <= 7 && posY-2 >= 0)
			kp << @board[posX+1][posY-2]
		end
		if (posX-1 >= 0 && posY+2 <= 7)
			kp << @board[posX-1][posY+2]
		end
		if (posX-1 >= 0 && posY-2 >= 0)
			kp << @board[posX-1][posY-2]
		end
		if (posX+2 <= 7 && posY+1 <= 7)
			kp << @board[posX+2][posY+1]
		end
		if (posX+2 <= 7 && posY-1 >= 0)
			kp << @board[posX+2][posY-1]
		end
		if (posX-2 >= 0 && posY+1 <= 7)
			kp << @board[posX-2][posY+1]
		end
		if (posX-2 >= 0 && posY-1 >= 0)
			kp << @board[posX-2][posY-1]
		end

		@path << kp
	end
end