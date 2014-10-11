require 'spec_helper'
require 'instructions'

describe 'instructions' do 

	let(:mars) {class_double("World").as_stubbed_const()}
	let(:file) { double("file.txt") }

	it 'opens the given file and saves the contents as a variable' do 
    expect(File).to receive(:read).with(file).and_return("file contents")
		nasa_orders = Instructions.new(file)
		expect(nasa_orders.instructions_string).to eq "file contents"
	end


end


# "5 3\n1 1 E\nRFRFRFRF\n\n3 2 N\nFRRFLLFFRRFLL\n\n0 3 W\nLLFFFLFLFL"