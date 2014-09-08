require 'rails_helper'

feature 'Homepage' do 
	context 'can and' do
		it 'should load properly' do
			visit root_path
			page.status_code.should be 200
		end	 
	end
end