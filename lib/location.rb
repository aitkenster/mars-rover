class Location
	def initialize
		@warning_messages = []
	end

	attr_accessor :warning_messages

	def leave_warning(direction)
		@warning_messages << direction unless @warning_messages.include?(direction)
	end

end