class Pawn
	attr_reader :color, :type
	def initialize (color)
		@color = color
		@type = "Pawn"
	end

	def toString
		"#{@color} #{@type}"
	end
end