require_relative "piece"

class Queen < Piece
	def initialize (color,unicode)
		super
		@type = "Queen"
		@unicode = unicode
	end

	def toString
		super
	end
end