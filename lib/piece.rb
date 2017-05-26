class Piece
	attr_reader :color, :type, :unicode

	def initialize (color,unicode)
		@color = color
		# @type = type
		# @unicode = unicode
	end

	def toString
		"#{@color} #{@type}"
	end
end