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
		canMove = true

		# this will call each individual piece's movePath functions, even though it doesn't exist in Piece
		movePath(from,to)

		# need to loop through path to find obsructions
		# but only up to the last element, because it's treated differently
		for i in 0..@path.length-2
			if @path[i] != nil
				canMove = false
			end
		end

		if (canMove == true)
			if (@path[-1] != nil)
				if (@path[-1].color != self.color)	# if the last element is path has a different color than the moved piece, it's allowed to move
					return true
				else
					return false
				end
			else
				return true
			end
		end

		# need to clear the path after we determine legality, so that there won't be leftover things when that piece moves again
		@path = []
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