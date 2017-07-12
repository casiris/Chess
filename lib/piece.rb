class Piece
	attr_reader :color, :type, :unicode, :path
	attr_accessor :position

	def initialize (color,unicode,pos)
		@color = color
		@path = []
		@position = pos
		@board
	end

	def toString
		"#{@color} #{@type}"
	end

	def isLegal (from,to,board)
		@board = board

		# check to make sure moved piece can even move in the given direction
		if (validateMove(from,to) == false)
			return false
		end

		# need to clear the path before we use it to make sure there aren't leftover things from when that piece last moved
		@path = []

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

	# king will call this to check if it's in check
	def check (from,board)
		@board = board
		fromX = from / 8
		fromY = from % 8
		@path = []

		#puts self.toString		# prints correct piece, ie, differentiates between pieces

		north(fromX,fromY,0)
		south(fromX,fromY,7)
		east(fromX,fromY,7)
		west(fromX,fromY,0)
		if (orthogonalCheck == true)
			return true
		end

		# orthogonal only works when the king moves into check, not when a piece puts the king in check
		# and that's because i'm calling it from the king in game
		# i might need to call it from the last piece moved

		northWest(fromX,fromY,0,0)
		northEast(fromX,fromY,0,7)
		if (northDiagonalCheck == true)
			return true
		end

		southWest(fromX,fromY,7,0)
		southEast(fromX,fromY,7,7)
		if (southDiagonalCheck == true)
			return true
		end

		if (knightCheck(from) == true)
			return true
		end
	end

	# check orthogonal directions for queen or rook
	def orthogonalCheck
		@path.each do |i|
			i.each do |j|
				if (j != nil)
					if (j.color != self.color && (j.type == "Queen" || j.type == "Rook"))
						return true
					else	# if we hit a non-queen or non-rook, don't check further in that direction
						break
					end
				end
			end
		end
		@path = []
		return false
	end

	# two different diagonal checks because black pawns can only threaten from the north, and white from the south
	def northDiagonalCheck
		@path.each do |i|
			if (i[0] != nil)
				# only check white king in north, because black king won't be checked by northern pawns (black pawns)
				if ((i[0].type == "Pawn" && i[0].color == "Black") && self.color == "White")
					return true
				end
			end
			i.each do |j|
				if (j != nil)
					if (j.color != self.color && (j.type == "Queen" || j.type == "Bishop"))
						return true
					else
						break
					end
				end
			end
		end
		@path = []
		return false
	end

	def southDiagonalCheck
		@path.each do |i|
			if (i[0] != nil)
				if ((i[0].type == "Pawn" && i[0].color == "White") && self.color == "Black")
					return true
				end
			end
			i.each do |j|
				if (j != nil)
					if (j.color != self.color && (j.type == "Queen" || j.type == "Bishop"))
						return true
					else
						break
					end
				end
			end
		end
		@path = []
		return false
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

	# something like this. can even rework the original directionals to work like this
	# then treat the resulting path differently depending on checking for moving vs move generation
	def northMoves (fromX,fromY,toX)
		n = []

		for i in toX..fromX-1
			# to get 0-63 index from x/y, we can just multiply x by 8 and then add y
			n << i*8+fromY
		end

		n.reverse!
		@path << n
	end

	def knightCheck (pos)
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

		kp.each do |i|
			if (i != nil)
				if (i.color != self.color && i.type == "Knight")
					@path = []
					return true
				end
			end
		end
		return false
	end
end


# next thing to do is knightCheck