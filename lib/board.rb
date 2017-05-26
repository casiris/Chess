require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"

class Board
    attr_accessor :board

    def initialize
    	bPawn = Pawn.new("Black","\u2659")
        bRook = Rook.new("Black","\u2656")
        bKnight = Knight.new("Black","\u2658")
        bBishop = Bishop.new("Black","\u2657")
        bQueen = Queen.new("Black","\u2655")
        bKing = King.new("Black","\u2654")
        wPawn = Pawn.new("White","\u265F")
        wRook = Rook.new("White","\u265C")
        wKnight = Knight.new("White","\u265E")
        wBishop = Bishop.new("White","\u265D")
        wQueen = Queen.new("White","\u265A")
        wKing = King.new("White","\u265B")
        @board = [[bRook,bKnight,bBishop,bQueen,bKing,bBishop,bKnight,bRook],
        		  [bPawn,bPawn,bPawn,bPawn,bPawn,bPawn,bPawn,bPawn],
        		  [],
        		  [],
        		  [],
        		  [],
        		  [wPawn,wPawn,wPawn,wPawn,wPawn,wPawn,wPawn,wPawn],
        		  [wRook,wKnight,wBishop,wQueen,wKing,wBishop,wKnight,wRook]]
    end

    def pieceAtIndex (x,y)
        # call the piece's toString method to output its name/color
        if (@board[x][y] != nil)
            return @board[x][y].toString
        else
            return "No piece at that position"
        end
    end

    def display
        puts @board[0][1].unicode
        # can't puts unicode of a range (needs to be an actual method)
        # but i probably want to do it a different way anyway, because the middle of the board is nil
    end
end

b = Board.new
puts b.pieceAtIndex(1,0)
b.display