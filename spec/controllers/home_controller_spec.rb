require 'rails_helper'

feature 'Homepage' do 
	context 'loading index page' do
		it 'should return status code of 200' do
			visit root_path
			expect(page.status_code).to eq(200)
		end	 
	end
end