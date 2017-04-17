require_relative "board"

def validateInput ()
end

b = Board.new
b.display

puts "Enter a piece to move"
from = gets.chomp
puts "Enter where to move"
to = gets.chomp

b.updateBoard(from.to_i,to.to_i)
b.display