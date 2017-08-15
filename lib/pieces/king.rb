require_relative "../piece"

class King < Piece
	def initialize (color,unicode)
		super
		@type = "King"
		@unicode = unicode
	end

	def generateMoves (board)
		xPos = @position / 8
		yPos = @position % 8

		@legalMoves = []

		northMoves(xPos,yPos)
		southMoves(xPos,yPos)
		eastMoves(xPos,yPos)
		westMoves(xPos,yPos)
		northEastMoves(xPos,yPos)
		northWestMoves(xPos,yPos)
		southEastMoves(xPos,yPos)
		southWestMoves(xPos,yPos)

		@legalMoves.delete([])

		# filter out everything beyond the first square in each direction, since the king can only move one square
		for i in 0..@legalMoves.length-1
			@legalMoves[i].slice!(1..@legalMoves[i].length-1)
		end

		# then filter out same colored pieces like normal
		filterMoves(board)
	end

	def check (board)
		xPos = self.position / 8
		yPos = self.position % 8
		@legalMoves = []

		northMoves(xPos,yPos)
		southMoves(xPos,yPos)
		eastMoves(xPos,yPos)
		westMoves(xPos,yPos)

		if (orthogonalCheck(board) == true)
			@legalMoves = []
			return true
		end

		northEastMoves(xPos,yPos)
		northWestMoves(xPos,yPos)

		if (northDiagonalCheck(board) == true)
			@legalMoves = []
			return true
		end

		southEastMoves(xPos,yPos)
		southWestMoves(xPos,yPos)

		if (southDiagonalCheck(board) == true)
			@legalMoves = []
			return true
		end

		knightMoves(position)
		if (knightCheck(board) == true)
			@legalMoves = []
			return true
		end
		@legalMoves = []
		return false
	end

	def orthogonalCheck (board)
		@legalMoves.each do |i|
			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && (board[x][y].type == "Queen" || board[x][y].type == "Rook"))
						return true
					else		# if we hit a non-queen or non-rook, don't check further in that direction
						break
					end
				end
			end
		end
		# @legalMoves = []
		return false
	end

	# two different diagonal checks because i need to check for two different types of pawns
	def northDiagonalCheck (board)
		@legalMoves.each do |i|
			if (i[0] != nil)
				x = i[0] / 8
				y = i[0] % 8
				# only check white king in north, because black king won't be checked by northern pawns (black pawns)
				if (board[x][y] != nil)
					if ((board[x][y].type == "Pawn" && board[x][y].color == "Black") && self.color == "White")
						return true
					end
				end
			end

			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && (board[x][y].type == "Queen" || board[x][y].type == "Bishop"))
						return true
					else
						break
					end
				end
			end
		end
		#@legalMoves = []
		return false
	end

	def southDiagonalCheck (board)
		@legalMoves.each do |i|
			if (i[0] != nil)
				x = i[0] / 8
				y = i[0] % 8
				if (board[x][y] != nil)
					if ((board[x][y].type == "Pawn" && board[x][y].color == "White") && self.color == "Black")
						return true
					end
				end
			end

			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && (board[x][y].type == "Queen" || board[x][y].type == "Bishop"))
						return true
					else
						break
					end
				end
			end
		end
		#@legalMoves = []
		return false
	end

	def knightCheck (board)
		@legalMoves.each do |i|
			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color != self.color && board[x][y].type == "Knight")
						return true
					end
				end
			end
		end
		#@legalMoves = []
		return false
	end

	def castle (from,to,board)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8
		castlePath = []

		# king side castle
		if ((fromY-toY).abs == 2)
			rook = board[fromX][fromY+3]
			
			if (self.hasMoved == false && rook.hasMoved == false)
				# need to get every position in the move, starting at king and ending at its final position
				for i in fromY..toY
					castlePath << (fromX*8 + i)
				end
				# loop through the middle of the path and see if those squares are blank
				for i in 1..castlePath.length-2
					x = castlePath[i] / 8
					y = castlePath[i] % 8

					if (board[x][y] != nil)
						return false
					end
				end
				# call check for every position in path
				castlePath.each do |i|
					if (check(i,board) == false)
						return true
					else
						return false
					end
				end
			else
				return false
			end
		else	# queen side castle
			rook = board[fromX][fromY-4]
			
			if (self.hasMoved == false && rook.hasMoved == false)
				for i in toY..fromY
					castlePath << (fromX*8 + i)
				end
				for i in 1..castlePath.length-2
					x = castlePath[i] / 8
					y = castlePath[i] % 8

					if (board[x][y] != nil)
						return false
					end
				end
				castlePath.each do |i|
					if (check(i,board) == false)
						return true
					else
						return false
					end
				end
			else
				return false
			end
		end
	end
end