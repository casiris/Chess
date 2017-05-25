require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"

class Board
    attr_accessor :board

    def initialize
    	pawn_black = Pawn.new("Black")
        @board = [[],
        		  [pawn_black,pawn_black,pawn_black,pawn_black,pawn_black,pawn_black,pawn_black,pawn_black],
        		  [],
        		  [],
        		  [],
        		  [],
        		  [],
        		  []]
    end

    def pieceAtIndex (x,y)
        # call the piece's toString method to output its name/color
        return @board[x][y].toString
    end
end

b = Board.new
puts b.pieceAtIndex(1,2)