class Player
	attr_accessor :name, :pieces

	def initialize (name,position)
		@name = name
		@pieces = []
		
		position.each do |i|
			@pieces << i
		end
	end
end