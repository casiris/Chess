require_relative "pieces/pawn"
require_relative "pieces/rook"
require_relative "pieces/knight"
require_relative "pieces/bishop"
require_relative "pieces/queen"
require_relative "pieces/king"

class Board
    attr_accessor :board, :whitePieces, :blackPieces

    def initialize
        # there's gotta be a better way to set unique positions
    	bPawn1 = Pawn.new("Black","\u2659",8)
        bPawn2 = Pawn.new("Black","\u2659",9)
        bPawn3 = Pawn.new("Black","\u2659",10)
        bPawn4 = Pawn.new("Black","\u2659",11)
        bPawn5 = Pawn.new("Black","\u2659",12)
        bPawn6 = Pawn.new("Black","\u2659",13)
        bPawn7 = Pawn.new("Black","\u2659",14)
        bPawn8 = Pawn.new("Black","\u2659",15)
        bRook1 = Rook.new("Black","\u2656",0)
        bRook2 = Rook.new("Black","\u2656",7)
        bKnight1 = Knight.new("Black","\u2658",1)
        bKnight2 = Knight.new("Black","\u2658",6)
        bBishop1 = Bishop.new("Black","\u2657",2)
        bBishop2 = Bishop.new("Black","\u2657",5)
        bQueen = Queen.new("Black","\u2655",3)
        bKing = King.new("Black","\u2654",4)
        wPawn1 = Pawn.new("White","\u265F",48)
        wPawn2 = Pawn.new("White","\u265F",49)
        wPawn3 = Pawn.new("White","\u265F",50)
        wPawn4 = Pawn.new("White","\u265F",51)
        wPawn5 = Pawn.new("White","\u265F",52)
        wPawn6 = Pawn.new("White","\u265F",53)
        wPawn7 = Pawn.new("White","\u265F",54)
        wPawn8 = Pawn.new("White","\u265F",55)
        wRook1 = Rook.new("White","\u265C",56)
        wRook2 = Rook.new("White","\u265C",63)
        wKnight1 = Knight.new("White","\u265E",57)
        wKnight2 = Knight.new("White","\u265E",62)
        wBishop1 = Bishop.new("White","\u265D",58)
        wBishop2 = Bishop.new("White","\u265D",61)
        wQueen = Queen.new("White","\u265B",59)
        wKing = King.new("White","\u265A",60)
        @board = [[bRook1,bKnight1,bBishop1,bQueen,bKing,bBishop2,bKnight2,bRook2],
        		  [bPawn1,bPawn2,bPawn3,bPawn4,bPawn5,bPawn6,bPawn7,bPawn8],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [wPawn1,wPawn2,wPawn3,wPawn4,wPawn5,wPawn6,wPawn7,wPawn8],
        		  [wRook1,wKnight1,wBishop1,wQueen,wKing,wBishop2,wKnight2,wRook2]]
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
        # will later need to re-add in the case of pawn promotion
        whitePieces.delete(nil)
        blackPieces.delete(nil)
        
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