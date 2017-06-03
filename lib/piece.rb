class Piece
	attr_reader :color, :type, :unicode

	def initialize (color,unicode)
		@color = color
		@path = []
	end

	def toString
		"#{@color} #{@type}"
	end

	def addToPath

	end

	def isLegal (from,to)
		return true		# just a placeholder

		# i guess what i should do is have another function that adds pieces to a path
		# and this function loops through and checks if there's an obstruction

		# the addToPath function would add differently depending on the type of piece. rooks would go up down left right, bishop on the diagonals, etc
		# and then a different function could check that path to see if the king is in the way, and if there are no obstructions, that'd be check
	end
end