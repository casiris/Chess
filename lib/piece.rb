class Piece
	attr_reader :color, :type, :unicode, :path

	def initialize (color,unicode)
		@color = color
		@path = []
	end

	def toString
		"#{@color} #{@type}"
	end

	def isLegal (from,to,board)
		#return true		# just a placeholder

		# this will call each individual piece's movePath functions, even though it doesn't exist in Piece
		movePath(from,to,board)

		# we need to filter out all directions, except for the direction the player wants to move (using "to")


		# then loop through each path and check for obstructions
		# path.each do |i|
		# 	i.each do |j|
		# 		if (board[i][j] != nil)
		# 			puts "can't move there"
		# 		else
		# 			puts "can move"
		# 		end
		# 	end
		# end
	end

	# [-1,0]
	def north (posX,posY,board)
		for i in 0..posX-1
			@path << board[posX-i][posY]
		end
		@path.reverse!
	end

	# [1,0]
	def south (posX,posY,board)
		for i in posX+1..7
			@path << board[posX+i][posY]
		end
	end

	# [0,1]
	def east (posX,posY,board)
		for i in posY+1..7
			@path << board[posX][posY+i]
		end
	end

	# [0,-1]
	def west (posX,posY,board)
		for i in 0..posY-1
			@path << board[posX][posY-i]
		end
		@path.reverse!
	end

	# [-1,1]
	def northEast (posX,posY,board)
		x = posX-1
		y = posY+1

		while (x >= 0 && y <= 7)
			@path << board[x][y]
			x -= 1
			y += 1
		end
	end

	# [-1,-1]
	def northWest (posX,posY,board)
		x = posX-1
		y = posY-1

		while (x >= 0 && y >= 0)
			@path << board[x][y]
			x -= 1
			y -= 1
		end
	end

	# [1,1]
	def southEast (posX,posY,board)
		x = posX+1
		y = posY+1

		while (x <= 7 && y <= 7)
			@path << board[x][y]
			x += 1
			y += 1
		end
	end

	# [1,-1]
	def southWest (posX,posY,board)
		x = posX+1
		y = posY-1

		while (x <= 7 && y >= 0)
			@path << board[x][y]
			x += 1
			y -= 1
		end
	end
end