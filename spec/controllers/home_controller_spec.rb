require 'rails_helper'

feature 'Homepage' do 
	context 'loading index page' do
		it 'should return status code of 200' do
			visit root_path
			page.status_code.should be 200
		end	 
	end
end