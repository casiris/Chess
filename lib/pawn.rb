require_relative 'piece'

class Pawn < Piece

	def initialize (color,unicode)
		super
		@type = "Pawn"
		@unicode = unicode
	end

	def toString
		super
	end
end

# p = Pawn.new("Blue","\u2659")
# puts p.toString
# puts p.unicode