require_relative 'piece'

class Pawn < Piece

	def initialize (color,unicode)
		super
		@type = "Pawn"
		@unicode = unicode
	end
end