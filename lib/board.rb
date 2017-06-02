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
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [wPawn,wPawn,wPawn,wPawn,wPawn,wPawn,wPawn,wPawn],
        		  [wRook,wKnight,wBishop,wQueen,wKing,wBishop,wKnight,wRook]]
        @file = ["a","b","c","d","e","f","g","h"]
    end

    def pieceAtIndex (position)
        # do math to get the x/y position from the given 0-63 index
        x = position / 8
        y = position % 8
        if (@board[x][y] != nil)
            return @board[x][y]
        else
            return nil
        end
    end

    def update (from,to)
        fromX = from / 8
        fromY = from % 8
        toX = to / 8
        toY = to % 8
        
        temp = @board[fromX][fromY]
        @board[fromX][fromY] = nil
        @board[toX][toY] = temp
    end

    def display
        puts ""
        puts "    #{@file.join(" ")}"     # print file
        puts ""
        for x in 0..7
            print "#{x+1} "      # print rank
            for y in 0..7
                if (@board[x][y] != nil)
                    print " #{@board[x][y].unicode}"
                else
                    print " _"
                end
            end
            puts ""
        end
        puts ""
    end
end

# update is kinda messy. it'd be nice to have just from/to. could do it with an array from[0]/from[1], or do math, or something else maybe