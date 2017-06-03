require_relative "piece"

class Queen < Piece
	def initialize (color,unicode)
		super
		@type = "Queen"
		@unicode = unicode
	end
end