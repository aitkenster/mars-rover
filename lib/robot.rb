class Robot

		def initialize(x, y, orientation)
			@position = "#{x},#{y}"
			@orientation = orientation
		end

		attr_accessor :position, :orientation

		def move(direction, location)
			if @position != "LOST"
				direction =~ /\A(?:L|R|)\z/ ? @orientation = turn(direction) : (go_forward if !flagged_as_dangerous?(location))
			end
		end

		def check_still_on(world, location)
			if !world.on_grid?(@position)
				leave_warning(location)
				mark_as_lost 
			end
		end

		def flagged_as_dangerous?(location)
			location.warning_messages.include?(@orientation)
		end

		def leave_warning(location)
			location.leave_warning(@orientation)
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

		def go_forward
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

		def mark_as_lost 
			@position = "LOST"
		end

end