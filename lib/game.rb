require_relative "board"
require_relative "player"
require_relative "pawn"

class Game
    #attr_accessor :board, :coordinate

    def initialize
        @board = Board.new
        @playerWhite = Player.new("White","A".ord.."Z".ord)     # ascii code of upper and lower case numbers
        @playerBlack = Player.new("Black","a".ord.."z".ord)
        @pawn = Pawn.new
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
        while (@board.pieceAtIndex(from) == "_" || !player.pieces.include?(@board.pieceAtIndex(from).ord))
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
        case piece
        when "p"
            @pawn.isLegal(from,to,true)
        when "P"
            @pawn.isLegal(from,to,false)
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
            while (movePiece(from,to,piece) == false || activePlayer.pieces.include?(@board.pieceAtIndex(to).ord))
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

            @board.updateBoard(from,to)
            @board.display
        end
    end
end

g = Game.new
g.gameLoop

# get input (what piece do you want to move?)
    # validate it
        # convert the rank and file to a number, return it
    # check board at that index
        # if it's empty (_), print out error and ask for another position
        # if it isn't, return that piece
# get second input (where to move to)
    # validate and convert the rank/file
    # call respective function for whatever piece was returned prior
        # check "to" for legality
            # if it isn't legal, ask for input again
            # if it is, update the board
            # switch player


# for check/mate, and i guess in the future for ai, i'll need a function to check what threatens a given square
# if i'm not mistaken, i'd just have to check in all 8 directions, and see if there's any applicable piece
# in that direction, ie, is there anything on any diagonal, and if so, is it a pawn 1 space away, or a bishop/queen
# any distance away, etc
# so, kinda like checking for connect four


# white moves
# make sure white can only move white pieces
    # i guess instead of keeping track of indicies, i could use ascii codes to determine which piece belongs to who
    # like, if the ascii code is between x-y it's lowercase, and x1-y1 is upppercase
# if a player moves a piece to a square that's not empty, check if it's an opposing piece
# if it is, call the capture function on the piece that was moved