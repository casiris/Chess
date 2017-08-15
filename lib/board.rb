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
    	bPawn1 = Pawn.new("Black","\u2659")
        bPawn2 = Pawn.new("Black","\u2659")
        bPawn3 = Pawn.new("Black","\u2659")
        bPawn4 = Pawn.new("Black","\u2659")
        bPawn5 = Pawn.new("Black","\u2659")
        bPawn6 = Pawn.new("Black","\u2659")
        bPawn7 = Pawn.new("Black","\u2659")
        bPawn8 = Pawn.new("Black","\u2659")
        bRook1 = Rook.new("Black","\u2656")
        bRook2 = Rook.new("Black","\u2656")
        bKnight1 = Knight.new("Black","\u2658")
        bKnight2 = Knight.new("Black","\u2658")
        bBishop1 = Bishop.new("Black","\u2657")
        bBishop2 = Bishop.new("Black","\u2657")
        bQueen = Queen.new("Black","\u2655")
        bKing = King.new("Black","\u2654")
        wPawn1 = Pawn.new("White","\u265F")
        wPawn2 = Pawn.new("White","\u265F")
        wPawn3 = Pawn.new("White","\u265F")
        wPawn4 = Pawn.new("White","\u265F")
        wPawn5 = Pawn.new("White","\u265F")
        wPawn6 = Pawn.new("White","\u265F")
        wPawn7 = Pawn.new("White","\u265F")
        wPawn8 = Pawn.new("White","\u265F")
        wRook1 = Rook.new("White","\u265C")
        wRook2 = Rook.new("White","\u265C")
        wKnight1 = Knight.new("White","\u265E")
        wKnight2 = Knight.new("White","\u265E")
        wBishop1 = Bishop.new("White","\u265D")
        wBishop2 = Bishop.new("White","\u265D")
        wQueen = Queen.new("White","\u265B")
        wKing = King.new("White","\u265A")
        @board = [[bRook1,bKnight1,bBishop1,bQueen,bKing,bBishop2,bKnight2,bRook2],
        		  [bPawn1,bPawn2,bPawn3,bPawn4,nil,bPawn6,bPawn7,bPawn8],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [nil,nil,nil,nil,nil,nil,nil,nil],
        		  [wPawn1,wPawn2,wPawn3,wPawn4,nil,wPawn6,wPawn7,wPawn8],
        		  [wRook1,wKnight1,wBishop1,wQueen,wKing,wBishop2,wKnight2,wRook2]]
        @whitePieces = @board[6][0..7] + @board[7][0..7]
        @blackPieces = @board[0][0..7] + @board[1][0..7]
        @file = ["a","b","c","d","e","f","g","h"]

        # loop through board and set each piece's position to their intial place in the array
        for i in 0..7
            for j in 0..7
                if (@board[i][j] != nil)
                    @board[i][j].position = i*8+j
                end
            end
        end
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

        # update pieces's position and flag that they have moved
        piece = pieceAtIndex(from)
        piece.position = to
        #piece.hasMoved = true

        # if a piece is captured, remove it from the appropriate array
        # will later need to re-add in the case of pawn promotion
        whitePieces.delete(nil)
        blackPieces.delete(nil)
        
        @board[toX][toY] = @board[fromX][fromY]
        @board[fromX][fromY] = nil
    end

    # creates a copy of the board to do a "soft" update when checking for checkmate
    # if i update regularly, sometimes pieces will disappear
    # probably because they get captured as a possible move to get out of check
    # and then when undoing the update, the piece is gone
    def tempUpdate (board,from,to)
        boardCopy = [[nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil],
                     [nil,nil,nil,nil,nil,nil,nil,nil]]
        # it's a hack, but it's the simplest way to copy an array in ruby
        for i in 0..7
            for j in 0..7
                boardCopy[i][j] = board[i][j]
            end
        end

        fromX = from / 8
        fromY = from % 8
        toX = to / 8
        toY = to % 8
        
        boardCopy[toX][toY] = boardCopy[fromX][fromY]
        boardCopy[fromX][fromY] = nil

        return boardCopy
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

    def pawnPromotion (type,position)
        x = position / 8
        y = position % 8
        piece = @board[x][y]

        if (piece.color == "Black")
            # need to get position in array of the promoted pawn
            oldPawn = 0
            for i in 0..whitePieces.length-1
                if (whitePieces[i].position == position)
                    oldPawn = i
                end
            end
            # update the board and array with the appropriate piece
            if (type == "rook")
                bRook3 = Rook.new("Black","\u2656")
                bRook3.position = position
                @board[x][y] = bRook3
                blackPieces[oldPawn] = bRook3
            elsif (type == "knight")
                bKnight3 = Knight.new("Black","\u2658")
                bKnight3.position = position
                @board[x][y] = bKnight3
                blackPieces[oldPawn] = bKnight3
            elsif (type == "bishop")
                bBishop3 = Bishop.new("Black","\u2657")
                bBishop3.position = position
                @board[x][y] = bBishop3
                blackPieces[oldPawn] = bBishop3
            else
                bQueen2 = Queen.new("Black","\u2655")
                bQueen2.position = position
                @board[x][y] = bQueen2
                blackPieces[oldPawn] = bQueen2
            end
        else
            oldPawn = 0
            for i in 0..whitePieces.length-1
                if (whitePieces[i].position == position)
                    oldPawn = i
                end
            end
            if (type == "rook")
                wRook3 = Rook.new("White","\u265C")
                wRook3.position = position
                @board[x][y] = wRook3
                whitePieces[oldPawn] = wRook3
            elsif (type == "knight")
                wKnight3 = Knight.new("White","\u265E")
                wKnight3.position = position
                @board[x][y] = wKnight3
                whitePieces[oldPawn] = wKnight3
            elsif (type == "bishop")
                wBishop3 = Bishop.new("White","\u265D")
                wBishop3.position = position
                @board[x][y] = wBishop3
                whitePieces[oldPawn] = wBishop3
            else
                wQueen2 = Queen.new("White","\u265B")
                wQueen2.position = position
                @board[x][y] = wQueen2
                whitePieces[oldPawn] = wQueen2
            end
        end
    end
end