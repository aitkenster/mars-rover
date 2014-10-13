class Instructions

	Dictionary = {:"L" => "Left", :"R" => "Right", :"F" => "Forward"}

	attr_accessor :unfulfilled_instructions, :current_robot_instruction, :world, :robot
	
	def initialize(file)
		convert_to_array(file)
	end


	def create_world
		@world = World.new(grid_size[0].to_i, grid_size[1].to_i)
	end

	def process_robot_instructions
		until @unfulfilled_instructions.empty?
			implement_instructions
		end
	end

	def implement_instructions
		place_new_robot
		get_set_of_instructions
		execute_order_list
		get_final_robot_position
	end

	def execute_order_list
		while !current_robot_instruction.empty?
			execute(current_robot_instruction.shift)
		end
	end

	def place_new_robot
		 @robot = Robot.new(@world, *position_instruction)
	end

	def get_final_robot_position
		@robot.return_position
	end

	def get_set_of_instructions
		p @current_robot_instruction = movement_instructions
	end

	def execute(command)
		translate(command).new(@robot, @robot.orientation, @robot.position)
	end

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