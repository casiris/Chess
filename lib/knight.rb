require_relative "piece"

class Knight < Piece
	def initialize (color,unicode)
		super
		@type = "Knight"
		@unicode = unicode
	end

	def toString
		super
	end
end