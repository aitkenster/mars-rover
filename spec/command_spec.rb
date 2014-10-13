require 'spec_helper'
require 'command'

describe 'commands' do 

	let(:robot){double :robot, resposition: nil}

	context 'when commanded to turn left' do

		it 'turns the robot to the left' do 
			# allow(robot).to receive(:resposition)
			expect(robot).to receive(:resposition).with("W", "3,3")
			left_command = Left.new(robot, "N", "3,3")
			left_command.execute
		end

	end

end

	context 'when commanded to turn left' do 

		it 'turns the robot to the right' do 
			expect(robot).to receive(:resposition).with("E", "3,3")
			right_command = Right.new(robot, "N", "3,3")
			right_command.execute
		end
	end

	context 'when commanded to go forward' do 
		it 'moves North' do 
			expect(robot).to receive(:resposition).with("N", "3,4")
			forward_command = Forward.new(robot, "N", "3,3")
			forward_command.execute
		end

		it 'moves South' do 
			expect(robot).to receive(:resposition).with("S", "3,2")
			forward_command = Forward.new(robot, "S", "3,3")
			forward_command.execute
		end

		it 'moves East' do 
			expect(robot).to receive(:resposition).with("E", "4,3")
			forward_command = Forward.new(robot, "E", "3,3")
			forward_command.execute
		end

		it 'moves West' do 
			expect(robot).to receive(:resposition).with("W", "2,3")
			forward_command = Forward.new(robot, "W", "3,3")
			forward_command.execute
		end

	end

end