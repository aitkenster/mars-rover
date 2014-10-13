require 'spec_helper'
require 'robot'

describe 'robot' do 

	let(:mars){double :mars, find: location}
	let(:curiosity){Robot.new(mars,"1","1","N")}
	let(:location){double :location, warning_messages: [], leave_warning: nil}

	context 'when created' do 
	
		let(:opportunity){Robot.new(mars, "1", "1", "N")}
	
		it 'has an initial world, location and orientation' do
			expect(curiosity.world).to eq(mars)
			expect(curiosity.position).to eq("1,1")
			expect(curiosity.orientation).to eq "N"
		end

		it 'can be repositioned' do 
			curiosity.reposition("W", "2,2")
			expect(curiosity.orientation).to eq ("W")
			expect(curiosity.position).to eq("2,2")
		end

		it 'will print out its position in the terminal' do
			allow(STDOUT).to receive(:puts).with("1 1 N")
			opportunity.return_position
		end

		it 'keeps track of its last position' do 
			curiosity.reposition("N", "1,2")
			expect(curiosity.last_position).to eq "1,1"
		end

	end

	context 'when it moves over the edge of the grid' do 

	let(:sojourner){Robot.new(world, "0","-1","S")}
	let(:world){double :world, find: nil}

		it 'is flagged as lost' do 
			allow(world).to receive(:find).with("1,1").and_return(location)
			sojourner.last_position = "1,1"
			sojourner.check_still_on_world
			expect(sojourner.lost).to eq true
		end

		it 'cant change position once flagged as lost' do 
			curiosity.lost = true
			curiosity.reposition("N", "2,1")
			expect(curiosity.position).to eq("1,1")
		end

		it 'leaves a warning message at its last location' do 
			curiosity.reposition("N", "1,2")
			curiosity.world = world
			allow(world).to receive(:find).with('1,1').and_return(location)
			curiosity.check_still_on_world
			expect(curiosity.lost).to eq true
			expect(location).to have_received(:leave_warning).with("N")
		end

		it 'prints out its last known postion followed by LOST in the terminal' do 
			curiosity.lost = true
			expect(STDOUT).to receive(:puts).with("1 1 N LOST")
			curiosity.return_position
		end

	end

	context 'when the location has a warning message' do

		let(:dangerous_location){double :location, warning_messages: ["N", "E"]}
		
		it 'will not move in the direction of the warning' do
			allow(mars).to receive(:find).with("1,1").and_return(dangerous_location)
			curiosity.reposition("N", "2,1")
			expect(curiosity.position).to eq("1,1")
		end

		it 'will still move in other directions' do 
				allow(mars).to receive(:find).with("1,1").and_return(dangerous_location)
				curiosity.reposition("W", "1,1")
				curiosity.reposition("W", "0,1")
				expect(curiosity.position).to eq("0,1")
		end

	end

end