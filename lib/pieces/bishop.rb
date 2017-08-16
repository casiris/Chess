require_relative "../piece"

class Bishop < Piece
	def initialize (color,unicode)
		super
		@type = "Bishop"
		@unicode = unicode
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8

		northWestMoves(posX,posY)
		northEastMoves(posX,posY)
		southWestMoves(posX,posY)
		southEastMoves(posX,posY)

		@legalMoves.delete([])

		filterSlidingMoves(board)
	end
end