# set up board to initial state
# ask for input (two separate things)
	# move which piece?
	# move where?

# maybe implement rows and columns as 1-8 A-H, which would return a number 1-64 (1d array seems easier)

class Board
	attr_accessor :board

	def initialize
		@board = [R,N,B,Q,K,B,N,R,
  				  P,P,P,P,P,P,P,P,
  				  _,_,_,_,_,_,_,_,
  				  _,_,_,_,_,_,_,_,
  				  _,_,_,_,_,_,_,_,
  				  _,_,_,_,_,_,_,_,
  				  P,P,P,P,P,P,P,P,
  				  R,N,B,Q,K,B,N,R]
	end

	def convertRankFile ()
	end

	def updateBoard (from, to)
	end
end