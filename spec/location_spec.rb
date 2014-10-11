require 'spec_helper'
require 'location'

describe 'location' do 

	let(:location){Location.new}

	context 'when created' do 

		it 'is empty' do 
			expect(location.contents).to be_empty
		end

		it 'is not flagged as an edge' do 
			expect(location.flagged?).to eq false
		end

	end

	context 'when it is a known edge' do 

		it 'is flagged with a warning message' do 
			location.leave_warning("W")
			expect(location.warning_message).to eq("W")
			expect(location.flagged?).to eq true
		end

	end

end