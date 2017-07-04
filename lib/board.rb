require_relative "pieces/pawn"
require_relative "pieces/rook"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"

class Board
    attr_accessor :board, :whitePieces, :blackPieces

    def initialize
    	bPawn = Pawn.new("Black","\u2659",0)
        bRook = Rook.new("Black","\u2656",0)
        bKnight = Knight.new("Black","\u2658",0)
        bBishop = Bishop.new("Black","\u2657",0)
        bQueen = Queen.new("Black","\u2655",0)
        bKing = King.new("Black","\u2654",4)
        wPawn = Pawn.new("White","\u265F",0)
        wRook = Rook.new("White","\u265C",0)
        wKnight = Knight.new("White","\u265E",0)
        wBishop = Bishop.new("White","\u265D",0)
        wQueen = Queen.new("White","\u265B",0)
        wKing = King.new("White","\u265A",60)
        @board = [[bRook,bKnight,bBishop,bQueen,bKing,bBishop,bKnight,bRook],
        		  [bPawn,bPawn,bPawn,nil,nil,nil,bPawn,bPawn],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,wPawn,nil,nil,nil,nil,wPawn,wPawn],
        		  [wRook,wKnight,wBishop,wQueen,wKing,wBishop,wKnight,wRook]]
        @whitePieces = @board[6][0..7] + @board[7][0..7]
        @blackPieces = @board[0][0..7] + @board[1][0..7]
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

        # update pieces's position. really only needed for king
        piece = pieceAtIndex(from)
        piece.position = to

        # if a piece is captured, remove it from the appropriate array
        if (@board[toX][toY] != nil)
            if (whitePieces.include?(@board[toX][toY]))
                whitePieces.delete(@board[toX][toY])
            elsif (blackPieces.include?(@board[toX][toY]))
                blackPieces.delete(@board[toX][toY])
            end
        end
        # will later need to re-add in the case of pawn promotion
        
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