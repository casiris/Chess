require_relative "piece"

class King < Piece
	def initialize (color,unicode)
		super
		@type = "King"
		@unicode = unicode
	end

	def toString
		super
	end
end