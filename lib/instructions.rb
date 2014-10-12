class Instructions
	def initialize(file)
		convert_to_array(file)
	end

	def convert_to_array(file)
		@split_instructions_array = File.read(file).chars.reject!{|char| char == " " || char == "\n"}
	end

	def create_world
		mars = World.new(grid_size[0].to_i, grid_size[1].to_i)
	end

	attr_accessor :split_instructions_array

	private

	def grid_size
		@grid_size ||= @split_instructions_array.shift(2)
	end


end