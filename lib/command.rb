class Command
	def initialize(robot, orientation, position)
		@robot = robot
		@orientation = orientation.dup
		@position = position.dup
		execute
	end

	def execute
	end

end

class Left < Command

	NewDirection = {
									:"N" => "W",
									:"S" => "E",
									:"E" => "N",
									:"W" => "S"
								}

	def execute
		@robot.reposition(turn(@orientation), @position)
	end

	def turn(orientation)
		NewDirection[:"#{orientation}"]
	end

end

class Right < Command

	NewDirection = {
									:"N" => "E",
									:"S" => "W",
									:"E" => "S",
									:"W" => "N"
								}

	def execute
		@robot.reposition(turn(@orientation), @position)
	end

	def turn(orientation)
		NewDirection[:"#{orientation}"]
	end

end

class Forward < Command

	def execute
		@robot.reposition(@orientation, move)
	end

	def move
		split_coordinates
		["N", "S"].include?(@orientation) ? move_vertically : move_horizontally
		return joined_coordinates
	end

	private

	def split_coordinates
		@position = @position.split(",").map(&:to_i)
	end

	def move_vertically
		@orientation == "N" ? @position[1] +=1 : @position[1]-=1
	end

	def move_horizontally
		@orientation == "E" ? @position[0]+=1 : @position[0]-=1
	end

	def joined_coordinates
		@position = @position.map(&:to_s).join(',')
	end
end

