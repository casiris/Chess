require_relative "../piece"

class Pawn < Piece
	attr_accessor :enPassant

	def initialize (color,unicode)
		super
		@type = "Pawn"
		@unicode = unicode
		@enPassant = nil
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8
		
		if (self.color == "Black")
			southMoves(posX,posY)
			southEastMoves(posX,posY)
			southWestMoves(posX,posY)
		else
			northMoves(posX,posY)
			northEastMoves(posX,posY)
			northWestMoves(posX,posY)
		end

		@legalMoves.delete([])

		filterPawnMoves(board)
	end

	def filterPawnMoves (board)
		# remove everything past the second position on the north/south
		@legalMoves[0].slice!(2..@legalMoves[0].length-1)
		# and remove the second if pawn has already moved
		if (@hasMoved == true)
			@legalMoves[0].slice!(1..@legalMoves[0].length-1)
		end
		# then remove any position that's occupied, whether by a same colored piece or opposite colored piece
		for i in 0..@legalMoves[0].length-1
			x = @legalMoves[0][i] / 8
			y = @legalMoves[0][i] % 8

			if (board[x][y] != nil)
				@legalMoves[0].slice!(i..@legalMoves[i].length-1)

				# if the first position is occupied, then pawn can't move to the second either, so we remove it too
				# but the possible second iteration of the loop still has to run, but there's nothing left, so break out
				if (i == 0)
					break
				end
			end
		end

		# remove everything past the first position on the diagonals
		for i in 1..@legalMoves.length-1
			@legalMoves[i].slice!(1..@legalMoves[i].length-1)

			# then remove any empty position, or a position where there is a same colored piece
			x = @legalMoves[i][0] / 8
			y = @legalMoves[i][0] % 8

			if (board[x][y] == nil)
				@legalMoves[i].delete(@legalMoves[i][0])
			elsif (board[x][y].color == self.color)
				@legalMoves[i].delete(@legalMoves[i][0])
			end
		end

		@legalMoves.delete([])
	end

	def checkPromotion
		pieces = ["rook","knight","bishop","queen"]

		if (self.color == "Black")
			# get x coord of position, see if pawn has made it to the other side
			if (self.position/8 == 7)
				puts "What piece do you want to promote pawn to?"
				promotion = gets.chomp

				while !(pieces.include?(promotion.downcase))
					puts "Not a valid piece. Try again"
					promotion = gets.chomp
				end
				return promotion
			end
		else
			if (self.position/8 == 0)
				puts "What piece do you want to promote pawn to?"
				promotion = gets.chomp

				while !(pieces.include?(promotion.downcase))
					puts "Not a valid piece. Try again"
					promotion = gets.chomp
				end
				return promotion
			end
		end
		return nil
	end

	def getEnPassant
		if (self.color == "Black")
			@enPassant = self.position-8
			return @enPassant
		else
			@enPassant = self.position+8
			return @enPassant
		end
	end
end