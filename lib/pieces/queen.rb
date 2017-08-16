require_relative "../piece"

class Queen < Piece
	def initialize (color,unicode)
		super
		@type = "Queen"
		@unicode = unicode
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8

		northMoves(posX,posY)
		southMoves(posX,posY)
		eastMoves(posX,posY)
		westMoves(posX,posY)
		northWestMoves(posX,posY)
		northEastMoves(posX,posY)
		southWestMoves(posX,posY)
		southEastMoves(posX,posY)

		# remove empty arrays, which occur when a piece can't move in that direction
		@legalMoves.delete([])

		filterSlidingMoves(board)
	end
end