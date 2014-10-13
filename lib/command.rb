class Command
	def initialize(robot, orientation, position)
		@robot = robot
		@orientation = orientation
		@position = position
	end

	def execute
	end

end

class Left < Command

	def execute
		@robot.reposition(turn(@orientation), @position)
	end

	def turn(orientation)
			case orientation
			when "N"
				"W"
			when "S"
				"E"
			when "E"
				"N"
			when "W"
				"S"
			end
	end

end

class Right < Command

	def execute
		@robot.reposition(turn(@orientation), @position)
	end

	def turn(orientation)
		case orientation
		when "N"
			"E"
		when "S"
			"W"
		when "E"
			"S"
		when "W"
			"N"
		end
	end

end

class Forward < Command

	def execute
		@robot.reposition(@orientation, move)
	end

	def move
		case @orientation
		when "N", "S"
			move_vertically
		when "E", "W"
			move_horizontally
		end
	end


	def move_vertically
		vertical_position = @position.slice!(2).to_i
		@position.insert(2,(@orientation == "N" ? vertical_position+=1 : vertical_position-=1).to_s)
	end

	def move_horizontally
		horizontal_position = @position.slice!(0).to_i
		@position.insert(0,(@orientation == "E" ? horizontal_position +=1 : horizontal_position -=1).to_s)
	end
end

