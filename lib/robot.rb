class Robot

		def initialize(world, x, y, orientation)
			@world = world
			@position = "#{x},#{y}"
			@orientation = orientation
			@lost = false
		end

		attr_accessor :world, :position, :orientation, :movements, :lost, :last_position

		def execute(movements)
			@movements.each{|instruction| move(instruction, current_location)}
			return_position
		end

		def current_location
			@world.find(@position)
		end

		def get_last_position
			@last_position = @position.dup
		end

		def check_still_on_world
			if !@world.find(@position)
				@position = @last_position
				leave_warning(@world.find(@last_position))
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

		def reposition(orientation, position)
			get_last_position
			check_still_on_world
			if !@lost
				@position = position unless flagged_as_dangerous?(current_location)
				@orientation = orientation 
			end
		end

private

		def mark_as_lost 
			@lost = true
		end

end