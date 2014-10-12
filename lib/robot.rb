class Robot

		def initialize(world, x, y, orientation, movements=[])
			@world = world
			@position = "#{x},#{y}"
			@orientation = orientation
			
			execute(@movements) if (@movements = movements).any?
			@lost = false
		end

		attr_accessor :world, :position, :orientation, :movements, :lost, :last_position

		def execute(movements)
			@movements.each{|instruction| move(instruction, current_location)}
		end

		def current_location
			@world.find(@position)
		end

		def get_last_position
			@last_position = @position.dup
		end

		def move(direction, location)
			get_last_position
			if !@lost
				direction =~ /\A(?:L|R|)\z/ ? @orientation = turn(direction) : (go_forward if !flagged_as_dangerous?(location))
			end
		end

		def check_still_on(world, location)
			if !world.find(@position)
				@position = @last_position
				leave_warning(@world.find(@position))
				mark_as_lost 
			end
		end

		def flagged_as_dangerous?(location)
			location.warning_messages.include?(@orientation)
		end

		def leave_warning(location)
			location.leave_warning(@orientation)
		end

		def return_position
			puts "#{@position.sub(",", " ")} #{@orientation}#{" LOST" if @lost}"
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
			@lost = true
		end

end