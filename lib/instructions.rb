class Instructions
	def initialize(file)
		convert_to_array(file)
	end

	def convert_to_array(file)
		@instructions_string = File.read(file)
	end

	attr_reader :instructions_string

end