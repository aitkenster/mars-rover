class Robot

		def initialize(x, y, direction)
			@position = "#{x},#{y}"
			@direction = direction
		end

		attr_reader :position, :direction
end