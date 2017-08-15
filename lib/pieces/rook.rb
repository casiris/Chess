require_relative "../piece"

class Rook < Piece
	def initialize (color,unicode)
		super
		@type = "Rook"
		@unicode = unicode
	end

	def generateMoves (board)
		posX = @position / 8
		posY = @position % 8

		@legalMoves = []

		northMoves(posX,posY)
		southMoves(posX,posY)
		eastMoves(posX,posY)
		westMoves(posX,posY)

		@legalMoves.delete([])

		filterSlidingMoves(board)
	end
end