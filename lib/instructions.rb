class Instructions
	def initialize(file)
		convert_to_array(file)
	end

	def create_world
		mars = World.new(grid_size[0].to_i, grid_size[1].to_i)
	end

	def process_robot_instructions
		while unfulfilled_instructions.any?
			get_set_of_instructions
			place_new_robot
		end
	end

	def place_new_robot
		robot = Robot.new(@current_robot_instruction[0], @current_robot_instruction[1], @current_robot_instruction[2], @current_robot_instruction[3])
	end

	def get_set_of_instructions
		@current_robot_instruction = position_instruction
		@current_robot_instruction << movement_instructions
	end

	attr_accessor :unfulfilled_instructions, :current_robot_instruction

	private

	def convert_to_array(file)
		@unfulfilled_instructions = File.read(file).chars.reject!{|char| char == " " || char == "\n"}
	end

	def grid_size
		@grid_size ||= @unfulfilled_instructions.shift(2)
	end

	def position_instruction
		@unfulfilled_instructions.shift(3)
	end

	def movement_instructions
		@unfulfilled_instructions.shift(@unfulfilled_instructions.take_while{|c| c =~ /[A-Z]/ }.count)
	end


end