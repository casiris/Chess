class Piece
	attr_reader :color, :type, :unicode

	def initialize (color,unicode)
		@color = color
		@path = []
	end

	def toString
		"#{@color} #{@type}"
	end

	def isLegal (from,to,board)
		return true		# just a placeholder

		# this will call each individual piece's addToPath functions, even though it doesn't exist in Piece
		# addToPath(from,to,board)

		# i guess what i should do is have another function that adds pieces to a path
		# and isLegal loops through that path and checks if there's an obstruction

		# the addToPath function would add differently depending on the type of piece. rooks would go up down left right, bishop on the diagonals, etc
		# and then a different function could check that path to see if the king is in the way, and if there are no obstructions, that'd be check

		# "north" is [-1,0], "east" is [0,1], etc. i might could add the direction to the piece's position to get the path
		# and then repeat for every direction necessary
	end

	# [-1,0]
	def north (posX,posY,board)
		northPath = []

		for i in 0..posX-1
			northPath << board[posX-i][posY]
		end
		return northPath.reverse!
	end

	# [1,0]
	def south (posX,posY,board)
		southPath = []

		for i in posX+1..7
			southPath << board[posX+i][posY]
		end
		return southPath
	end

	# [0,1]
	def east (posX,posY,board)
		eastPath = []

		for i in posY+1..7
			eastPath << board[posX][posY+i]
		end
		return eastPath
	end

	# [0,-1]
	def west (posX,posY,board)
		westPath = []

		for i in 0..posY-1
			westPath << board[posX][posY-i]
		end
		return westPath.reverse!
	end

	# [-1,1]
	def northEast (posX,posY,board)
		northEastPath = []
		x = posX-1
		y = posY+1

		while (x >= 0 && y <= 7)
			northEastPath << board[x][y]
			x -= 1
			y += 1
		end
		return northEastPath
	end

	# [-1,-1]
	def northWest (posX,posY,board)
		northWestPath = []
		x = posX-1
		y = posY-1

		while (x >= 0 && y >= 0)
			northWestPath << board[x][y]
			x -= 1
			y -= 1
		end
		return northWestPath
	end

	# [1,1]
	def southEast (posX,posY,board)
		southEastPath = []
		x = posX+1
		y = posY+1

		while (x <= 7 && y <= 7)
			southEastPath << board[x][y]
			x += 1
			y += 1
		end
		return southEastPath
	end

	# [1,-1]
	def southWest (posX,posY,board)
		southWestPath = []
		x = posX+1
		y = posY-1

		while (x <= 7 && y >= 0)
			southWestPath << board[x][y]
			x += 1
			y -= 1
		end
		return southWestPath
	end
end