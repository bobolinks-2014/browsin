require 'rails_helper'

describe SearchController do 
	let(:movie) {Media.create!(imdb_id: "testing", service_list: "hbo", platform_list: "shows", run_time: 50, actor_list: "Cersei, Arya, Brienne", rating: 100)}
	let(:movie_all) {[movie].to_json(:include => [:genres, :services, :actors])}
	let(:user) {User.create!(email: "testing@testing.com", password: "testing", password_confirmation: "testing")}

	describe 'search route' do 
		before(:each) do
			user.tag(movie, with: :"show", on: :status)
			allow(movie).to receive(:runtime_search){30} 
			allow(SearchController).to receive(:current_user){ user }
		end

		it "search for '60 minutes' gets a successful response" do
			get(:search,
				:query => 'I have 60 minutes',
				:format => 'json')
			expect(response).to be_success
		end

		it "search for '60 minutes' returns a single movie" do
			get(:search,
				:query => "60 minutes",
				:format => 'json')
			expect(response.body).to eq(movie_all)
		end

		it "search for '20 minutes' returns no movies" do
			get(:search,
				:query => "20 minutes",
				:format => 'json')
			expect(response.body).to eq({success: false, error: '20 minutes'}.to_json)
		end


	end
end