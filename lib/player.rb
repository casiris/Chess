require_relative "board"

class Player
	attr_reader :color

	def initialize (color)
		@color = color
	end

	def switchPlayer
		if (@color == "White")
			@color = "Black"
		else
			@color = "White"
		end
	end
end