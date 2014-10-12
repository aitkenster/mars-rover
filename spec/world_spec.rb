require 'spec_helper'
require 'World'

describe 'World' do 

	context 'when created' do 

	let(:mars){World.new(4,2)}
	let(:location) {class_double("Location").as_stubbed_const()}

	#need to refactor the allow statements
		it 'has a size determined by the user imput' do 
			allow(location).to receive(:new)
			expect(mars.grid.count).to eq 15
		end

		it 'each coordinate is a location' do 
			allow(location).to receive(:new).and_return(location)
			allow(location).to receive(:class).and_return("Location")
			expect(mars.grid["1,1"].class).to eq "Location" 
		end

		it 'will return a location based on a value' do 
			expect(mars.find("1,1").class).to eq Location
		end

	end

end