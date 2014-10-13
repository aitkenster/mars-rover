class Instructions

	Dictionary = {:"L" => "Left", :"R" => "Right", :"F" => "Forward"}

	def initialize(file)
		convert_to_array(file)
	end

	def create_world
		@world = World.new(grid_size[0].to_i, grid_size[1].to_i)
	end

	def process_robot_instructions
		while !@unfulfilled_instructions.empty?
			get_set_of_instructions
			place_new_robot
			execute_order_list
			@robot.return_position
		end
	end

	def execute_order_list
		while !current_robot_instruction[3].empty?
			execute(current_robot_instruction[3].shift)
		end
	end

	def place_new_robot
		 @robot = Robot.new(@world, @current_robot_instruction[0], @current_robot_instruction[1], @current_robot_instruction[2])
	end

	def get_set_of_instructions
		@current_robot_instruction = position_instruction
		@current_robot_instruction << movement_instructions
	end

	def execute(command)
		translate(command).new(@robot, @robot.orientation, @robot.position)
	end

	attr_accessor :unfulfilled_instructions, :current_robot_instruction, :world, :robot

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

	def translate(command)
		return Object.const_get(Dictionary[:"#{command}"])
	end


end