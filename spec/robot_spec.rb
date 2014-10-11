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

		it 'moves North' do 
			curiosity.move("F")
			expect(curiosity.position).to eq("1,2")
		end

		it 'moves South' do 
			curiosity = Robot.new("1","1","S")
			curiosity.move("F")
			expect(curiosity.position).to eq("1,0")
		end

		it 'moves East' do 
			curiosity = Robot.new("1","1","E")
			curiosity.move("F")
			expect(curiosity.position).to eq("2,1")
		end

		it 'moves West' do 
			curiosity = Robot.new("1","1","W")
			curiosity.move("F")
			expect(curiosity.position).to eq("0,1")
		end


	end

end