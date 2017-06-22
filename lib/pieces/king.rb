require_relative "../piece"

class King < Piece
	def initialize (color,unicode)
		super
		@type = "King"
		@unicode = unicode
	end

	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		# prevent the king from moving if it would put itself in check
		if (notInCheck(toX,toY) == false)
			return false
		end
		if (knightCheck(to) == false)
			return false
		end

		if (@board[toX][toY] == nil || @board[toX][toY].color != self.color)
			if ((fromX-toX).abs == 1 && fromY-toY == 0)
				return true
			elsif (fromX-toX == 0 && (fromY-toY).abs == 1)
				return true
			elsif ((fromX-toX).abs == (fromY-toY).abs && (fromX-toX).abs == 1)
				return true
			else
				return false
			end
		else
			return false
		end
	end

	def movePath (from,to)
		# doesn't need a path, but still need a function to call
	end

	def kingPath (pos)
		# king can't check other king, because it'd put itself in check too
	end


	# returns false if king would be in check
	def notInCheck (posX,posY)

		north(posX,posY,0)
		if (orthogonalCheck == false)
			return false
		end

		south(posX,posY,7)
		if (orthogonalCheck == false)
			return false
		end

		east(posX,posY,7)
		if (orthogonalCheck == false)
			return false
		end

		west(posX,posY,0)
		if (orthogonalCheck == false)
			return false
		end

		northWest(posX,posY,0,0)
		if (northDiagonalCheck == false)
			return false
		end

		northEast(posX,posY,0,7)
		if (northDiagonalCheck == false)
			return false
		end

		southWest(posX,posY,7,0)
		if (southDiagonalCheck == false)
			return false
		end

		southEast(posX,posY,7,7)
		if (southDiagonalCheck == false)
			return false
		end
	end

	# see if there's a rook or queen putting the king in check
	def orthogonalCheck
		if (@path[0][0] != nil)
			if (@path[0][0].color != self.color && @path[0][0].type == "King")
				return false
			end
		end
		@path[0].each do |i|
			if (i != nil)
				if (i.color != self.color && (i.type == "Rook" || i.type == "Queen"))
					return false
				else
					# if we hit some non-rook/queen, we know we aren't in check
					break
				end
			end
		end
		@path = []
		return true
	end

	# two different diagonal checks for the two different pawns
	# black can only threaten if they're north, white if they're south
	def northDiagonalCheck
		if (@path[0][0] != nil)
			if ((@path[0][0].color != self.color && @path[0][0].type == "King") || @path[0][0].color == "Black" && @path[0][0].type == "Pawn")
				return false
			# need to make sure black king won't be prevented to move by its own pawns
			elsif (self.color == "White")
				if (@path[0][0].color == "Black" && @path[0][0].type == "Pawn")
					return false
				end
			end
		end
		@path[0].each do |i|
			if (i != nil)
				if (i.color != self.color && (i.type == "Bishop" || i.type == "Queen"))
					return false
				else
					break
				end
			end
		end
		@path = []
		return true
	end

	def southDiagonalCheck
		if (@path[0][0] != nil)
			if (@path[0][0].color != self.color && @path[0][0].type == "King")
				return false
			# have to make sure white king won't be prevented to move by its own pawns
			elsif (self.color == "Black")
				if (@path[0][0].color == "White" && @path[0][0].type == "Pawn")
					return false
				end
			end
		end
		@path[0].each do |i|
			if (i != nil)
				if (i.color != self.color && (i.type == "Bishop" || i.type == "Queen"))
					return false
				else
					break
				end
			end
		end
		@path = []
		return true
	end

	def knightCheck (pos)
		knightPath(pos)
		#puts @path
		@path[0].each do |i|
			if (i != nil)
				if (i.color != self.color && i.type == "Knight")
					@path = []
					return false
				end
			end
		end
		@path = []
		return true
	end
end

# now work on only being able to move king if the move wouldn't put it in check
# i think the best way to do it is have the king check every direction (and 8 knight squares)
# to see if there's an opposing piece there
# i'd also have to make sure the right piece is in the right direction, ie, a bishop or queen on a diagonal, but not a rook