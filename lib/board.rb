class Board
    attr_accessor :board

    def initialize
        @board = [["r","n","b","q","k","b","n","r"],
                  ["p","p","p","p","p","p","p","p"],
                  ["_","_","_","_","_","_","_","_"],
                  ["_","_","_","_","_","_","_","_"],
                  ["_","_","_","_","_","_","_","_"],
                  ["_","_","_","_","_","_","_","_"],
                  ["P","P","P","P","P","P","P","P"],
                  ["R","N","B","Q","K","B","K","R"]]
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