require 'rails_helper'

RSpec.describe UserPreference, :type => :model do
	let(:user){User.create!(email: "test@test.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}
	let(:media){Media.create!(imdb_id: "testing", platform_list: "shows", service_list: "hbo")}
	let(:wrong_pref){UserPreference.create}
	let(:right_pref){UserPreference.create(user_id: user.id, imdb_id: media.imdb_id, view_status: "hide")}

	describe 'validations' do
		it 'should return an error if user id is missing' do
			expect(wrong_pref.errors[:user_id].any?).to be_truthy
		end

		it 'should return an error if IMDB id is missing' do 
			expect(wrong_pref.errors[:imdb_id].any?).to be_truthy
		end

		it 'should return an error if view status is missing' do
			expect(wrong_pref.errors[:view_status].any?).to be_truthy
		end
	end

	describe 'associations' do 
		it 'should have a user' do 
			expect(right_pref.user).to eq(user) 
		end

		it 'should have a media' do 
			expect(right_pref.media).to eq(media) 
		end
	end
end
