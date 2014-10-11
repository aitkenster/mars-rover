class Robot

		def initialize(x, y, orientation)
			@position = "#{x},#{y}"
			@orientation = orientation
		end

		attr_reader :position, :orientation

		def move(direction)
			direction == "L" || "R" ? @orientation = turn(direction) : "go forward"
		end

private

		def turn(direction)
			case @orientation
			when "N"
				direction == "L" ? "W" : "E"
			when "S"
				direction == "L" ? "E" : "W"
			when "E"
				direction == "L" ? "N" : "S"
			when "W"
				direction == "L" ? "S" : "N"
			end
		end

end