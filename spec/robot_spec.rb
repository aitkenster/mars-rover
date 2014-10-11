require 'spec_helper'
require 'robot'

describe 'robot' do 

	context 'when created' do 
		it 'has an initial location and direction' do
			curiosity = Robot.new("1", "1", "N")
			expect(curiosity.position).to eq("1,1")
			expect(curiosity.direction).to eq "N"
		end
	end

end