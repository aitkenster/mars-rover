class Robot

		def initialize(world, x, y, orientation)
			@world = world
			@position = "#{x},#{y}"
			@orientation = orientation
			@last_position = @position.dup
		end

		attr_accessor :world, :position, :orientation, :movements, :lost, :last_position

		def reposition(new_orientation, new_position)
			return if lost?
			forward_request_not_flagged_as_dangerous?(new_position) ? process_forward_request(new_position) : update(new_orientation)
			update_last_known_position if !lost?
		end

		def forward_request_not_flagged_as_dangerous?(new_position)
			new_position != @position && !flagged_as_dangerous?
		end

		def process_forward_request(new_position)
			@position = new_position
			declare_lost if lost?
		end

		def update(new_orientation)
			@orientation = new_orientation
		end

		def lost?
			@world.find(@position) == nil
		end

		def current_location
			@world.find(@position)
		end

		def update_last_known_position
			@last_position = @position.dup
		end

		def flagged_as_dangerous?
			current_location.warning_messages.include?(@orientation)
		end

		def return_position
			puts "#{@last_position.sub(",", " ")} #{@orientation}#{" LOST" if @lost}"
		end

private

		def declare_lost
			mark_as_lost
			leave_warning(@world.find(@last_position))
		end

		def leave_warning(location)
			location.leave_warning(@orientation)
		end		

		def mark_as_lost 
			@lost = true
		end

end