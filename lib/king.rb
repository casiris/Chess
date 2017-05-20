class King
	def isLegal (from,to)
		fromX = from / 8
		fromY = from % 8
		toX = to / 8
		toY = to % 8

		if ((toX-fromX).abs == 1 || (toY-fromY).abs == 1 || ((toX-fromX.abs == toY-fromY.abs) && (toX-fromX.abs == 1)))
			return true
		else
			return false
		end
	end
end


# board = [["\u2656","\u2658","\u2657","\u2655","\u2654","\u2657","\u2658","\u2656"],
#                   ["\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659","\u2659"],
#                   ["_","_","_","_","_","_","_","_"],
#                   ["_","_","_","_","_","_","_","_"],
#                   ["_","_","_","_","_","_","_","_"],
#                   ["_","_","_","_","_","_","_","_"],
#                   ["_","_","_","_","_","_","_","_"],
#               	  ["_","_","_","\u265A","_","_","_","_"]]

# k = King.new
# puts k.isLegal(59,51)                  