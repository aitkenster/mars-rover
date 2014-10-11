require 'spec_helper'
require 'World'

describe 'World' do 

	context 'when created' do 

		it 'has a size determined by the user imput' do 
			mars = World.new(5,3)
			expect(mars.grid.count).to eq 24
		end

	end

end