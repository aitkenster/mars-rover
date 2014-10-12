require 'spec_helper'
require 'instructions'

describe 'instructions' do 

	let(:mars) {class_double("World").as_stubbed_const()}
	let(:nasa_orders) {Instructions.new(file)}
	let(:file) { double :file, read: "fil e"}

	it 'saves the contents of the given file as an array' do 
    expect(File).to receive(:read).with(file).and_return("fil e")
		expect(nasa_orders.split_instructions_array).to eq(["f", "i", "l", "e"])
	end

	it 'takes the first line of the file as the grid params' do
		allow(File).to receive(:read).with(file).and_return("5 3\n1 1 E")
		expect(mars).to receive(:new).with(5, 3)
		nasa_orders.create_world
	end

	# it 'splits the rest of the file into individual robot instructions' do 
	# 	nasa_orders.split_instructions_array = ["1", "1", "E", "\n", "R", "F", "R", "F", "R", "F", "R", "F", "\n", "\n", "3", "2", "N", "\n", "F", "R", "R", "F", "L", "L", "F", "F", "R", "R", "F", "L", "L", "\n", "\n", "0", "3", "W", "\n", "L", "L", "F", "F", "F", "L", "F", "L", "F", "L"] 

	# end

end

# "5 3\n1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL"

# ["5", "3", "\n", "1", "1", "E", "\n", "R", "F", "R", "F", "R", "F", "R", "F", "\n", "\n", "3", "2", "N", "\n", "F", "R", "R", "F", "L", "L", "F", "F", "R", "R", "F", "L", "L", "\n", "\n", "0", "3", "W", "\n", "L", "L", "F", "F", "F", "L", "F", "L", "F", "L"] 
