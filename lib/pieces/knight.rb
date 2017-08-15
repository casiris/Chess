require_relative "../piece"

class Knight < Piece
	def initialize (color,unicode)
		super
		@type = "Knight"
		@unicode = unicode
	end

	def generateMoves (board)
		@legalMoves = []
		
		knightMoves(@position)
		@legalMoves.delete([])

		filterMoves(board)
	end
end