require 'spec_helper'
require 'World'

describe 'World' do 

		let(:mars){World.new(4,2)}
		let(:location) {class_double("Location").as_stubbed_const()}

	context 'when created' do 

		before(:each) do
			allow(mars).to receive(:new).and_return(Location)
		end

		it 'has a size determined by the user imput' do 
			expect(mars.grid.count).to eq 15
		end

		it 'each coordinate is a location' do 
			expect(mars.grid["1,1"].class).to eq Location 
		end

		it 'will return a location based on a value' do 
			expect(mars.find("1,1").class).to eq Location
		end

	end

end