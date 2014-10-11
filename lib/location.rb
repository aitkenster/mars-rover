class Location
	def initialize
		self.contents = []
		self.warning_message = ""
	end

	attr_accessor :contents, :warning_message

	def flagged?
		!warning_message.empty?
	end

	def leave_warning(direction)
		self.warning_message = direction
	end

end