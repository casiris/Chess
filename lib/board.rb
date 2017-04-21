class Board
	attr_accessor :board

	def initialize
		@board = ["r","n","b","k","q","b","n","r",
				  "p","p","p","p","p","p","p","p",
				  "_","_","_","_","_","_","_","_",
				  "_","_","_","_","_","_","_","_",
				  "_","_","_","_","_","_","_","_",
				  "_","_","_","_","_","_","_","_",
				  "P","P","P","P","P","P","P","P",
				  "R","N","B","K","Q","B","K","R"]
		@rank = ["a","b","c","d","e","f","g","h"]
		file = [1,2,3,4,5,6,7,8]
	end

	def pieceAtIndex (index)
		return @board[index]
	end

	def updateBoard (from, to)
		temp = @board[from]
		@board[from] = "_"
		@board[to] = temp
	end

	def display
		puts ""
		print "		    "
		puts @rank[0..7].join(" ")
		puts ""
		print "		1   "
		puts @board[0..7].join(" ")
		print "		2   "
		puts @board[8..15].join(" ")
		print "		3   "
		puts @board[16..23].join(" ")
		print "		4   "
		puts @board[24..31].join(" ")
		print "		5   "
		puts @board[32..39].join(" ")
		print "		6   "
		puts @board[40..47].join(" ")
		print "		7   "
		puts @board[48..55].join(" ")
		print "		8   "
		puts @board[56..63].join(" ")
		puts ""
	end
end