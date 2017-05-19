require_relative "board"
require_relative "player"
require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"

class Game
    #attr_accessor :board, :coordinate

    def initialize
        @board = Board.new
        @playerWhite = Player.new("White","\u265A".."\u265F")     # unicode of black/white chess pieces
        @playerBlack = Player.new("Black","\u2654".."\u2659")
        @pawn = Pawn.new
        @rook = Rook.new
        @knight = Knight.new
        @bishop = Bishop.new
        @coordinate = [ "a1","b1","c1","d1","e1","f1","g1","h1",
                        "a2","b2","c2","d2","e2","f2","g2","h2",
                        "a3","b3","c3","d3","e3","f3","g3","h3",
                        "a4","b4","c4","d4","e4","f4","g4","h4",
                        "a5","b5","c5","d5","e5","f5","g5","h5",
                        "a6","b6","c6","d6","e6","f6","g6","h6",
                        "a7","b7","c7","d7","e7","f7","g7","h7",
                        "a8","b8","c8","d8","e8","f8","g8","h8"]
    end

    def getFrom (player)
        puts "Player #{player.name}, enter a piece to move"
        from = getInput

        # make sure player can't choose an empty square or a piece they don't own
        while (@board.pieceAtIndex(from) == "_" || !player.pieces.include?(@board.pieceAtIndex(from)))
            puts "No piece at that position, try again"
            from = getInput
        end
        return from
    end

    def getInput
        input = gets.chomp

        while (validateInput(input) == false)
            puts "Invalid positon, try somewhere else"
            input = gets.chomp
        end
        return validateInput(input)
    end

    def convertRankFile (coord)
        if (@coordinate.include?(coord.downcase))
            return @coordinate.index(coord.downcase)
        else
            return -1
        end
    end

    # need to make sure it's in the format "a1" or whatever, not a number
    def validateInput (input)
        index = convertRankFile(input.to_s)

        if (index.between?(0,63))
            return index
        else
            return false
        end
    end

    def movePiece (from,to,piece)
        #puts "hey: #{piece}"
        case piece
        when "♙"        # black pawn
            # make sure pawns can only move forward to an empty space
            if (@board.pieceAtIndex(to) == "_")
                @pawn.isLegal(from,to,true)
            else
                @pawn.capture(from,to,true)
            end
        when "♟"        # white pawn
            if (@board.pieceAtIndex(to) == "_")
                @pawn.isLegal(from,to,false)
            else
                @pawn.capture(from,to,false)
            end
        when "♖"        # black rook
            @rook.isLegal(from,to,@board.board)
        when "♜"        # white rook
            #puts "white rook"
            @rook.isLegal(from,to,@board.board)
        when "♘"        # black knight
            @knight.isLegal(from,to)
        when "♞"        # white knight
            @knight.isLegal(from,to)
        when "♝"        # white bishop
            @bishop.isLegal(from,to,@board.board)
        when "♗"        # black bishop
            @bishop.isLegal(from,to,@board.board)
        else
        end
    end

    def gameLoop
        @board.display
        activePlayer = @playerWhite
        win = false

        while (win == false)
            from = getFrom(activePlayer)
            piece = @board.pieceAtIndex(from)

            puts "Enter where to move"
            to = getInput

            # make sure player can't make an invalid move, or move to a square already occupied by their own piece
            # then, allow player to choose another piece instead
            while (movePiece(from,to,piece) == false || activePlayer.pieces.include?(@board.pieceAtIndex(to)))
                puts "Can't move that piece there"

                from = getFrom(activePlayer)
                piece = @board.pieceAtIndex(from)
                puts "Enter where to move"
                to = getInput
            end

            # switch player turn
            if (activePlayer == @playerWhite)
                activePlayer = @playerBlack
            else
                activePlayer = @playerWhite
            end

            #puts "from: #{from}, to: #{to}"
            #puts "#{@board.pieceAtIndex(from)}, #{@board.pieceAtIndex(to)}"

            @board.updateBoard(from,to)
            @board.display
        end
    end
end

g = Game.new
g.gameLoop


# for check/mate, and i guess in the future for ai, i'll need a function to check what threatens a given square
# if i'm not mistaken, i'd just have to check in all 8 directions, and see if there's any applicable piece
# in that direction, ie, is there anything on any diagonal, and if so, is it a pawn 1 space away, or a bishop/queen
# any distance away, etc
# so, kinda like checking for connect four