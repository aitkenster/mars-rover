require 'spec_helper'
require 'location'

describe 'location' do 

	let(:location){Location.new}

	context 'when created' do 

		it 'is does not have any warning messages' do 
			expect(location.warning_messages).to be_empty
		end

	end

	context 'when it is a known edge' do 

		it 'is flagged with a warning message' do 
			location.leave_warning("W")
			expect(location.warning_messages).to include("W")
		end

		it 'can have multiple direction warnings' do 
			location.leave_warning("W")
			location.leave_warning("N")
			expect(location.warning_messages).to include("W")
			expect(location.warning_messages).to include("N")
		end

	end

end