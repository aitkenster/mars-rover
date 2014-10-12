require 'spec_helper'
require 'instructions'

describe 'instructions' do 

	let(:nasa_orders) {Instructions.new(file)}
	let(:file) { double :file, read: "fil e"}
	let(:mars) {class_double("World").as_stubbed_const()}
	let(:robot) {class_double("Robot").as_stubbed_const()}

	context 'processing instructions'

		it 'saves the contents of the given file as an array' do 
	    expect(File).to receive(:read).with(file).and_return("fil \ne")
			expect(nasa_orders.unfulfilled_instructions).to eq(["f", "i", "l", "e"])
		end

		it 'takes the first line of the file as the grid params' do
			allow(File).to receive(:read).with(file).and_return("5 3\n1 1 E")
			expect(mars).to receive(:new).with(5, 3)
			nasa_orders.create_world
		end

		it 'splits the rest of the file into individual robot instructions' do 
			allow(File).to receive(:read).with(file).and_return("1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL")
			nasa_orders.get_set_of_instructions
			expect(nasa_orders.current_robot_instruction).to eq(["1", "1","E", ["R", "F", "R", "F", "R", "F", "R", "F"]])
			expect(nasa_orders.unfulfilled_instructions).to eq(["3", "2", "N", "F", "R", "R", "F", "L", "L", "F", "F", "R", "R", "F", "L", "L", "0", "3", "W", "L", "L", "F", "F", "F", "L", "F", "L", "F", "L"])
		end

	context 'executing instructions' do 

		it 'feeds the instructions to a robot' do
			allow(File).to receive(:read).with(file).and_return("test")
			nasa_orders.current_robot_instruction = ["1", "1","E", ["R", "F", "R", "F", "R", "F", "R", "F"]]
			expect(robot).to receive(:new).with("1", "1", "E", ["R", "F", "R", "F", "R", "F", "R", "F"])
			nasa_orders.place_new_robot
		end

	end

end

# "5 3\n1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL"

# ["5", "3", "\n", "1", "1", "E", "\n", "R", "F", "R", "F", "R", "F", "R", "F", "\n", "\n", "3", "2", "N", "\n", "F", "R", "R", "F", "L", "L", "F", "F", "R", "R", "F", "L", "L", "\n", "\n", "0", "3", "W", "\n", "L", "L", "F", "F", "F", "L", "F", "L", "F", "L"] 

# ["1", "1", "E", "R", "F", "R", "F", "R", "F", "R", "F", ["3", "2", "N", "F", "R", "R", "F", "L", "L", "F", "F", "R", "R", "F", "L", "L", "0", "3", "W", "L", "L", "F", "F", "F", "L", "F", "L", "F", "L"]] 