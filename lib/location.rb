class Location
	def initialize
		@contents = []
		@warning_message = ""
	end

	attr_accessor :contents, :warning_message

	def flagged?
		!@warning_message.empty?
	end

	def leave_warning(direction)
		@warning_message = direction
	end

end