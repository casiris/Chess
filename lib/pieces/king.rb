require_relative "../piece"

class King < Piece
	def initialize (color,unicode,pos)
		super
		@type = "King"
		@unicode = unicode
	end

	def validateMove (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

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
		# doesn't need a path, but still needs a function to call
		@path = [[]]
	end

	def generateMoves (pos)
		@path = [[]]
	end

	def check (position,board)
		xPos = position / 8
		yPos = position % 8
		@path = []

		northMoves(xPos,yPos,0)
		southMoves(xPos,yPos,7)
		eastMoves(xPos,yPos,7)
		westMoves(xPos,yPos,0)
		orthogonalCheck(board)

		northEastMoves(xPos,yPos,0,7)
		northWestMoves(xPos,yPos,0,0)
		northDiagonalCheck(board)

		southEastMoves(xPos,yPos,7,7)
		southWestMoves(xPos,yPos,7,0)
		southDiagonalCheck(board)
	end

	def orthogonalCheck (board)
		@path.each do |i|
			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && (board[x][y].type == "Queen" || board[x][y].type == "Rook"))
						puts "king in check by queen or rook"
						return true
					else		# if we hit a non-queen or non-rook, don't check further in that direction
						break
					end
				end
			end
		end
		@path = []
		return false
	end

	# two different diagonal checks because i need to check for two different types of pawns
	def northDiagonalCheck (board)
		@path.each do |i|
			if (i[0] != nil)
				x = i[0] / 8
				y = i[0] % 8
				# only check white king in north, because black king won't be checked by northern pawns (black pawns)
				if (board[x][y] != nil)
					if ((board[x][y].type == "Pawn" && board[x][y].color == "Black") && self.color == "White")
						puts "check by black pawn"
						return true
					end
				end
			end

			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && (board[x][y].type == "Queen" || board[x][y].type == "Bishop"))
						puts "king in check by queen or bishop"
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

	def southDiagonalCheck (board)
		@path.each do |i|
			if (i[0] != nil)
				x = i[0] / 8
				y = i[0] % 8
				if (board[x][y] != nil)
					if ((board[x][y].type == "Pawn" && board[x][y].color == "White") && self.color == "Black")
						puts "check by white pawn"
						return true
					end
				end
			end

			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && (board[x][y].type == "Queen" || board[x][y].type == "Bishop"))
						puts "king in check by queen or bishop"
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
end