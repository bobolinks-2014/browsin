require 'rails_helper'

describe SearchController do 
	let(:got) {Media.create!(imdb_id: "testing123", service_list: "hbo", platform_list: "shows", run_time: 50, actor_list: "Cersei, Arya, Brienne", rating: 100, genre_list: "Drama")}
	let(:got_json) {[got].to_json(:include => [:genres, :services, :actors])}
	let(:hoc) {Media.create!(imdb_id: "testing321", service_list: "netflix", platform_list: "shows", run_time: 50, actor_list: "Frank, Claire", rating: 90, genre_list: "Comedy")}
	let(:hoc_json) {[hoc].to_json(:include => [:genres, :services, :actors])}
	let(:all_movies) {[got, hoc].to_json(:include => [:genres, :services, :actors])}
	let(:user) {User.create!(email: "testing@testing.com", password: "testing", password_confirmation: "testing")}
	let(:error) {{success: false, error: '20 minutes'}.to_json}

	describe 'search route' do 
		before(:each) do
			user.tag(got, with: :"show", on: :status)
			user.tag(hoc, with: :"show", on: :status)
			allow(got).to receive(:runtime_search){50} 
			allow(hoc).to receive(:runtime_search){50} 
			allow(SearchController).to receive(:current_user){user}
		end

		it "search for '60 minutes' gets a successful response" do
			get(:search,
				:query => 'I have 60 minutes',
				:format => 'json')
			expect(response).to be_success
		end

		it "search for '60 minutes' returns two movies" do
			get(:search,
				:query => "60 minutes",
				:format => 'json')
			expect(response.body).to eq(all_movies)
		end

		it "search for '20 minutes' returns no movies" do
			get(:search,
				:query => "20 minutes",
				:format => 'json')
			expect(response.body).to eq(error)
		end

		it "search for 'drama' returns one movie" do
			get(:search,
				:query => "DRAMA",
				:format => 'json')
			expect(response.body).to eq(got_json)
		end

		it "search for '60 minutes and comedy' returns one movie" do
			get(:search,
				:query => "60 minutes and comedy",
				:format => 'json')
			expect(response.body).to eq(hoc_json)
		end
	end
end