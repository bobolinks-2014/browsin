require 'rails_helper'
require 'json'

RSpec.describe UsersController, :type => :controller do

	describe 'create route' do 
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

	describe 'show route' do
		let(:user){User.create!(email: "bobo@bobo.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}
		let(:media){Media.create!(imdb_id: "testing", service_list: "hbo", platform_list: "shows")}
		let(:preference){UserPreference.create!(user_id: user.id, imdb_id: media.imdb_id, view_status: "hide")}
		let(:media_json){JSON.parse(media.to_json)}

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
			expect(JSON.parse(response.body)['user']).to include('hidden_media' => [media_json])
		end

		it "should return a user's service list" do
			get :show
			expect(JSON.parse(response.body)['user']['service_list']).to eq(['hbo'])
		end
	end

	describe 'edit route' do
		let(:user){User.create!(email: "bobo@bobo.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}

		before(:each) do
			allow_any_instance_of(UsersController).to receive(:current_user).and_return(user)
			allow_any_instance_of(UsersController).to receive(:user_signed_in?).and_return(true)
		end

		it "should update the user's service list" do
			get(:edit,
				:service_list => 'hbo, netflix',
				:format => 'json')
			expect(user.service_list).to eq(['hbo', 'netflix'])
		end

		it "should return success: true for when user's service is updated" do
			get(:edit,
				:service_list => 'hbo, netflix',
				:format => 'json')
			expect(JSON.parse(response.body)['success']).to eq(true)
		end

		it "should return success: false for when user is not signed in" do
			allow_any_instance_of(UsersController).to receive(:user_signed_in?).and_return(false)
			get(:edit,
				:service_list => 'hbo, netflix',
				:format => 'json')
			expect(JSON.parse(response.body)['success']).to eq(false)
		end
	end

	describe 'add route' do
		let(:user){User.create!(email: "bobo@bobo.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}
		let(:media){Media.create!(imdb_id: "testing", service_list: "hbo", platform_list: "shows")}
		let(:preference){UserPreference.create!(user_id: user.id, imdb_id: media.imdb_id, view_status: "hide")}

		before(:each) do
			allow_any_instance_of(UsersController).to receive(:current_user).and_return(user)
			allow_any_instance_of(UserPreference).to receive(:where).and_return(preference)
		end

		it 'should return success: true when user preference is added' do
			post(:add,
				:item_id => 'testing',
				:format => 'json')
			expect(response.body).to eq({success: true}.to_json)
		end

		it 'should return increase user preference by 1' do
			post(:add,
				:item_id => 'testing',
				:format => 'json')
			expect(UserPreference.count).to eq(1)
		end
	end

	describe 'remove route' do
		let(:user){User.create!(email: "bobo@bobo.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}
		let(:media){Media.create!(imdb_id: "testing", service_list: "hbo", platform_list: "shows")}
		let(:preference){UserPreference.create!(user_id: user.id, imdb_id: media.imdb_id, view_status: "show")}

		before(:each) do
			allow_any_instance_of(UsersController).to receive(:current_user).and_return(user)
		end

		it 'should create a new user preference' do
			post(:remove,
				:id => 'bobobo',
				:format => 'json')
			expect(UserPreference.count).to eq(1)
		end

		# it 'it should update an existing user preference' do
		# 	test = UserPreference.create(user_id: user.id, imdb_id: "browsin", view_status: 'show')
		# 	post(:remove,
		# 		:id => 'browsin', 
		# 		:format => 'json')
		# 	expect(test.view_status).to eq('hide')
		# end

	end
end
