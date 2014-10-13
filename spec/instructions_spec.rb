require 'spec_helper'
require 'instructions'

describe 'instructions' do 

	let(:file) { double :file}
	let(:nasa_orders) {Instructions.new(file)}
	let(:world) {class_double("World").as_stubbed_const()}
	let(:robot) {class_double("Robot").as_stubbed_const()}

	before(:each) do 
			allow(File).to receive(:read).with(file).and_return("1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL")
	end

	context 'processing instructions'

		it 'saves the contents of the given file as an array' do 
	    expect(File).to receive(:read).with(file).and_return("fil \ne")
			expect(nasa_orders.unfulfilled_instructions).to eq(["f", "i", "l", "e"])
		end

		it 'takes the first line of the file as the world params' do
			allow(File).to receive(:read).with(file).and_return("5 3\n1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL")
			expect(world).to receive(:new).with(5, 3)
			nasa_orders.create_world
		end

		it 'splits the rest of the file into individual robot instructions' do 
			nasa_orders.get_set_of_instructions
			expect(nasa_orders.current_robot_instruction).to eq(["1", "1","E", ["R", "F", "R", "F", "R", "F", "R", "F"]])
		end

	context 'executing instructions' do 

		before(:each) do
			nasa_orders.world = world
		end

		it 'positions a new robot' do
			nasa_orders.current_robot_instruction = ["1", "1","E", ["R", "F", "R", "F", "R", "F", "R", "F"]]
			expect(robot).to receive(:new).with(world, "1", "1", "E")
			nasa_orders.place_new_robot
		end

		it 'feeds a command to the robot' do 
			nasa_orders.robot = double :rover, orientation: "N", position: "1,2"
			command = class_double("Left").as_stubbed_const()
			expect(command).to receive(:new).with(nasa_orders.robot, "N", "1,2")
			nasa_orders.execute("L")
		end

		it 'continues to feed instructions until there are none left' do 
			allow(robot).to receive(:new)
			nasa_orders.process_robot_instructions
			expect(nasa_orders.unfulfilled_instructions).to be_empty
		end
	end

end
