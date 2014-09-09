require 'rails_helper'
require 'json'

RSpec.describe UsersController, :type => :controller do

	describe '#create' do 
		it 'should create a new user' do 
			get(:create,
				:user => {email: "bobo@bobo.com", password: "testing", password_confirmation: "testing"},
				:services => {:services => ["hbo","netflix"]}, 
				:format => 'json')
			expect(User.count).to eq(1)
		end

		it 'should return success: true for valid new user' do 
			get(:create,
				:user => {email: "bobo@bobo.com", password: "testing", password_confirmation: "testing"},
				:services => {:services => ["hbo","netflix"]}, 
				:format => 'json')
			expect(JSON.parse(response.body)['success']).to eq(true)
		end

		it 'should return success: false for invalid new user' do
			get(:create,
				:user => {email: "bobo@bobo.com"},
				:services => {:services => ["hbo","netflix"]}, 
				:format => 'json')
			expect(JSON.parse(response.body)['success']).to eq(false)
		end
	end

	describe '#show' do
		let(:user){User.create!(email: "bobo@bobo.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}
		let(:media){Media.create!(imdb_id: "testing", service_list: "hbo", platform_list: "shows")}
		let(:preference){UserPreference.create!(user_id: user.id, imdb_id: media.imdb_id, view_status: "hide")}
		let(:media_json){media.to_json}
		let(:media_parsed){JSON.parse(media_json)}

		before(:each) do
			allow_any_instance_of(UsersController).to receive(:current_user).and_return(user)
			allow_any_instance_of(User).to receive(:hidden_media).and_return([media])
		end

		it "should return a user's email" do
			get :show
			expect(JSON.parse(response.body)['user']['email']).to eq('bobo@bobo.com')
		end

		it "should return a user's hidden media" do
			get :show
			expect(JSON.parse(response.body)['user']).to include('hidden_media' => [media_parsed])
		end
	end
end
