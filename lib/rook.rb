require_relative "piece"

class Rook < Piece
	def initialize (color,unicode)
		super
		@type = "Rook"
		@unicode = unicode
	end
end