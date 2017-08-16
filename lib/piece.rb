class Piece
	attr_reader :color, :type, :unicode, :path
	attr_accessor :position, :hasMoved, :legalMoves

	def initialize (color,unicode)
		@color = color
		@hasMoved = false
		@legalMoves = []
	end

	def toString
		return "#{@color} #{@type}"
	end

	def isLegal (to,board)
		generateMoves(board)

		# if to is included within legalMoves, then the move is valid
		@legalMoves.each do |i|
			i.each do |j|
				if (to == j)
					# clear legalMoves after we're done so there's nothing left over before the next move
					@legalMoves = []
					return true
				end
			end
		end

		@legalMoves = []
		return false
	end

	# remove any positions from legalMoves that a same color piece is occupying
	def filterMoves (board)
		@legalMoves.each do |i|
			i.each do |j|
				x = j / 8
				y = j % 8
				if (board[x][y] != nil)
					if (board[x][y].color == self.color)
						i.delete(j)
					end
				end
			end
		end
		# remove empty arrays as a result of the filtering
		@legalMoves.delete([])
	end

	# remove any position after an occupied position
	# then check the last position in each direction and remove same colored positions
	def filterSlidingMoves (board)
		for i in 0..@legalMoves.length-1
			for j in 0..@legalMoves[i].length-2
				x = @legalMoves[i][j] / 8
				y = @legalMoves[i][j] % 8

				if (board[x][y] != nil)
					@legalMoves[i].slice!(j+1..@legalMoves[i].length-1)
					break
				end
			end
		end
		for i in 0..@legalMoves.length-1
			x = @legalMoves[i][-1] / 8
			y = @legalMoves[i][-1] % 8

			if (board[x][y] != nil)
				if (board[x][y].color == self.color)
					@legalMoves[i].delete(@legalMoves[i][-1])
				end
			end
		end
		@legalMoves.delete([])
	end

	# have each direction be their own array within legalMoves. makes it easier to check only a certain direction for obstructions
	# [-1,0]
	def northMoves (fromX,fromY)
		n = []

		for i in 0..fromX-1
			# to get 0-63 index from x/y, we can just multiply x by 8 and then add y
			n << i*8+fromY
		end

		n.reverse!
		@legalMoves << n
	end

	# [1,0]
	def southMoves (fromX,fromY)
		s = []

		for i in fromX+1..7
			s << i*8+fromY
		end

		@legalMoves << s
	end

	# [0,1]
	def eastMoves (fromX,fromY)
		e = []

		for i in fromY+1..7
			e << fromX*8+i
		end

		@legalMoves << e
	end

	# [0,-1]
	def westMoves (fromX,fromY)
		w = []

		for i in 0..fromY-1
			w << fromX*8+i
		end

		w.reverse!
		@legalMoves << w
	end

	# [-1,1]
	def northEastMoves (fromX,fromY)
		ne = []
		x = fromX-1
		y = fromY+1

		while (x >= 0 && y <= 7)
			ne << x*8+y
			x -= 1
			y += 1
		end

		@legalMoves << ne
	end

	# [-1,-1]
	def northWestMoves (fromX,fromY)
		nw = []
		x = fromX-1
		y = fromY-1

		while (x >= 0 && y >= 0)
			nw << x*8+y
			x -= 1
			y -= 1
		end

		@legalMoves << nw
	end

	# [1,1]
	def southEastMoves (fromX,fromY)
		se = []
		x = fromX+1
		y = fromY+1

		while (x <= 7 && y <= 7)
			se << x*8+y
			x += 1
			y += 1
		end

		@legalMoves << se
	end

	# [1,-1]
	def southWestMoves (fromX,fromY)
		sw = []
		x = fromX+1
		y = fromY-1

		while (x <= 7 && y >= 0)
			sw << x*8+y
			x += 1
			y -= 1
		end

		@legalMoves << sw
	end

	def knightMoves (position)
		# it's hacky but i need each direction in knight's path to be in a separate array, for parallelism later
		# and this doesn't seem to mess up king's check function
		kp1 = []
		kp2 = []
		kp3 = []
		kp4 = []
		kp5 = []
		kp6 = []
		kp7 = []
		kp8 = []
		xPos = position / 8
		yPos = position % 8

		# need to make sure we don't get out of bounds
		if (xPos+1 <= 7 && yPos+2 <= 7)
			kp1 << (xPos+1)*8 + (yPos+2)
		end
		if (xPos+1 <= 7 && yPos-2 >= 0)
			kp2 << (xPos+1)*8 + (yPos-2)
		end
		if (xPos+2 <= 7 && yPos+1 <= 7)
			kp3 << (xPos+2)*8 + (yPos+1)
		end
		if (xPos+2 <= 7 && yPos-1 >= 0)
			kp4 << (xPos+2)*8 + (yPos-1)
		end
		if (xPos-1 >= 0 && yPos+2 <= 7)
			kp5 << (xPos-1)*8 + (yPos+2)
		end
		if (xPos-1 >= 0 && yPos-2 >= 0)
			kp6 << (xPos-1)*8 + (yPos-2)
		end
		if (xPos-2 >= 0 && yPos+1 <= 7)
			kp7 << (xPos-2)*8 + (yPos+1)
		end
		if (xPos-2 >= 0 && yPos-1 >= 0)
			kp8 << (xPos-2)*8 + (yPos-1)
		end

		@legalMoves << kp1 << kp2 << kp3 << kp4 << kp5 << kp6 << kp7 << kp8
	end
end