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

		def on_world?
			@world.find(@position) != nil
		end

		def check_still_on_world
			if !@world.find(@position)
				@position = @last_position
				leave_warning(@world.find(@last_position))
				mark_as_lost 
			end
		end

		def flagged_as_dangerous?
			current_location.warning_messages.include?(@orientation)
		end

		def leave_warning(location)
			location.leave_warning(@orientation)
		end

		def return_position
			puts "#{@last_position.sub(",", " ")} #{@orientation}#{" LOST" if @lost}"
		end

		def reposition(new_orientation, new_position)
				return if @lost
				if new_position != @position && flagged_as_dangerous? == false
					@position = new_position
				 if @world.find(@position) == nil
				 	declare_lost
				 	return
				 end
				else
					@orientation = new_orientation
				end
				get_last_position
		end

		def declare_lost
			mark_as_lost
			leave_warning(@world.find(@last_position))
		end

private

		def mark_as_lost 
			@lost = true
		end

end