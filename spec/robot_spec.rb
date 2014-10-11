require 'spec_helper'
require 'robot'

describe 'robot' do 

	let(:curiosity){Robot.new("1","1","N")}

	context 'when created' do 
		it 'has an initial location and orientation' do
			expect(curiosity.position).to eq("1,1")
			expect(curiosity.orientation).to eq "N"
		end
	end

	context 'when given a command' do 
		it 'turns left' do
			curiosity.move("L")
			expect(curiosity.orientation).to eq "W"
		end

		it 'turns right' do 
			curiosity.move("R")
			expect(curiosity.orientation).to eq "E"
		end
	end

end