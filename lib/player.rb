class Player
	attr_reader :color

	def initialize (color)
		@color = color
	end

	def test
		puts @color
	end
end

p = Player.new("Blue")
puts p
puts p.color