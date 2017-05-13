class Board
    attr_accessor :board

    def initialize
        @board = [["\u2656","\u2658","\u2657","\u2655","\u2654","\u2657","\u2658","\u2656"],
                  ["\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659"],
                  ["_","_","_","_","_","_","_","_"],
                  ["_","_","_","_","_","_","_","_"],
                  ["_","_","_","_","_","_","_","_"],
                  ["_","_","_","_","_","_","_","_"],
                  ["\u265F","\u265F","\u265F","\u265F","\u265F","\u265F","\u265F","\u265F"],
                  ["\u265C","\u265E","\u265D","\u265A","\u265C","\u265D","\u265E","\u265C"]]
        @rank = ["a","b","c","d","e","f","g","h"]
        file = [1,2,3,4,5,6,7,8]
    end

    def convert (position)
        # this takes the 0-63 index of the 1d array and does math to get the x/y index instead
        x = position / 8
        y = position % 8
        return [x,y]
    end

    def pieceAtIndex (index)
        pos = convert(index)
        return @board[pos[0]][pos[1]]
    end

    def updateBoard (from, to)
        newFrom = convert(from)
        newTo = convert(to)
        temp = @board[newFrom[0]][newFrom[1]]
        @board[newFrom[0]][newFrom[1]] = "_"
        @board[newTo[0]][newTo[1]] = temp
    end

    def display
        puts ""
        print "         "
        puts @rank[0..7].join(" ")
        puts ""

        for i in 0..@board.length-1
            print "     #{i+1}   "
            puts @board[i][0..7].join(" ")
        end

        puts ""
    end
end

# b = Board.new
# b.display
# puts b.pieceAtIndex(7)