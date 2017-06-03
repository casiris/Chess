require_relative "piece"

class Bishop < Piece
	def initialize (color,unicode)
		super
		@type = "Bishop"
		@unicode = unicode
	end
end

# bishop can move [1,1], [1,-1], [-1, 1], or [-1,-1]
# probably a good idea to eventually make use of an array with possible moves for every piece