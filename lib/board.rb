class Board
	attr_accessor :board

	def initialize
		@board = ["R","N","B","K","Q","B","K","R",
				  "P","P","P","P","P","P","P","P",
				  "_","_","_","_","_","_","_","_",
				  "_","_","_","_","_","_","_","_",
				  "_","_","_","_","_","_","_","_",
				  "_","_","_","_","_","_","_","_",
				  "P","P","P","P","P","P","P","P",
				  "R","N","B","K","Q","B","K","R"]
	end

	def convertRankFile ()
	end

	def isLegal
	end

	def updateBoard (from, to)
		temp = @board[from]
		@board[from] = "_"
		@board[to] = temp
	end

	def display
		puts @board[0..7].join(" ")
		puts @board[8..15].join(" ")
		puts @board[16..23].join(" ")
		puts @board[24..31].join(" ")
		puts @board[32..39].join(" ")
		puts @board[40..47].join(" ")
		puts @board[48..55].join(" ")
		puts @board[56..63].join(" ")
	end
end