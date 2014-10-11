require 'spec_helper'
require 'robot'

describe 'robot' do 

	let(:curiosity){Robot.new("1","1","N")}
	let(:lost_robot){Robot.new("0","-1","S")}
	let(:world){double :world, on_grid?: false}
	let(:location){double :location, warning_messages: [], leave_warning: nil}
	let(:dangerous_location){double :location, warning_messages: ["N", "E"]}

	context 'when created' do 
		it 'has an initial location and orientation' do
			expect(curiosity.position).to eq("1,1")
			expect(curiosity.orientation).to eq "N"
		end
	end

	context 'when given a command to turn' do 
		it 'turns left' do
			curiosity.move("L", location)
			expect(curiosity.orientation).to eq "W"
		end

		it 'turns right' do 
			curiosity.move("R", location)
			expect(curiosity.orientation).to eq "E"
		end

	end

	context 'when the location does not have a warning message' do 

		it 'moves North' do 
			curiosity.move("F", location)
			expect(curiosity.position).to eq("1,2")
		end

		it 'moves South' do 
			curiosity = Robot.new("1","1","S")
			curiosity.move("F", location)
			expect(curiosity.position).to eq("1,0")
		end

		it 'moves East' do 
			curiosity = Robot.new("1","1","E")
			curiosity.move("F", location)
			expect(curiosity.position).to eq("2,1")
		end

		it 'moves West' do 
			curiosity = Robot.new("1","1","W")
			curiosity.move("F", location)
			expect(curiosity.position).to eq("0,1")
		end
	end

	context 'when it moves over the edge of the grid' do 

		it 'is flagged as lost' do 
			lost_robot.check_still_on(world, location)
			expect(lost_robot.position).to eq("LOST")
		end

		it 'cant change position once flagged as lost' do 
			lost_robot.position = "LOST"
			lost_robot.move("F", location)
			expect(lost_robot.position).to eq("LOST")
		end

		it 'leaves a warning message at its last location' do 
			curiosity.move("F", location)
			curiosity.check_still_on(world, location)
			expect(curiosity.position).to eq("LOST")
			expect(location).to have_received(:leave_warning).with("N")
		end

	end

	context 'when the location does have a warning message' do
		
		it 'will not move in the direction of the warning' do
			curiosity.move("F", dangerous_location)
			expect(curiosity.position).to eq("1,1")
		end
	end

	it 'will still move in other directions' do 
			curiosity.move("L", dangerous_location)
			curiosity.move("F", dangerous_location)
			expect(curiosity.position).to eq("0,1")
	end

end