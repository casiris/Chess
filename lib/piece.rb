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

		puts @path

		# need to loop through path to find obsructions
		# but only up to the last element, because it's treated differently
		# also, only need to check first array in path, because there's only one array when checking movement
		for i in 0..@path[0].length-2
			if (@path[0][i] != nil)
				xPos = @path[0][i] / 8
				yPos = @path[0][i] % 8
				piece = @board[xPos][yPos]

				if (piece != nil)
					return false
				end
			end
		end

		if (@path[0][-1] != nil)
			xPos = @path[0][-1] / 8
			yPos = @path[0][-1] % 8
			piece = @board[xPos][yPos]
			return checkLastTileInPath(piece)
		else
			return true
		end
	end

	def checkLastTileInPath(piece)
		if (piece != nil)
			if (piece.color != self.color)
				return true
			else
				return false
			end
		else
			return true
		end
	end

	# [-1,0]
	def northMoves (fromX,fromY,toX)
		n = []

		for i in toX..fromX-1
			# to get 0-63 index from x/y, we can just multiply x by 8 and then add y
			n << i*8+fromY
		end

		n.reverse!
		@path << n
	end

	# [1,0]
	def southMoves (fromX,fromY,toX)
		s = []

		for i in fromX+1..toX
			s << i*8+fromY
		end

		@path << s
	end

	# [0,1]
	def eastMoves (fromX,fromY,toY)
		e = []

		for i in fromY+1..toY
			e << fromX*8+i
		end

		@path << e
	end

	# [0,-1]
	def westMoves (fromX,fromY,toY)
		w = []

		for i in toY..fromY-1
			w << fromX*8+i
		end

		w.reverse!
		@path << w
	end

	# [-1,1]
	def northEastMoves (fromX,fromY,toX,toY)
		ne = []
		x = fromX-1
		y = fromY+1

		while (x >= toX && y <= toY)
			ne << x*8+y
			x -= 1
			y += 1
		end

		@path << ne
	end

	# [-1,-1]
	def northWestMoves (fromX,fromY,toX,toY)
		nw = []
		x = fromX-1
		y = fromY-1

		while (x >= toX && y >= toY)
			nw << x*8+y
			x -= 1
			y -= 1
		end

		@path << nw
	end

	# [1,1]
	def southEastMoves (fromX,fromY,toX,toY)
		se = []
		x = fromX+1
		y = fromY+1

		while (x <= toX && y <= toY)
			se << x*8+y
			x += 1
			y += 1
		end

		@path << se
	end

	# [1,-1]
	def southWestMoves (fromX,fromY,toX,toY)
		sw = []
		x = fromX+1
		y = fromY-1

		while (x <= toX && y >= toY)
			sw << x*8+y
			x += 1
			y -= 1
		end

		@path << sw
	end
end


# next thing to do is knightCheck