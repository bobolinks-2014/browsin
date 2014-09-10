require 'rails_helper'

describe SearchController do

	describe 'search route' do
		let(:user) {User.create!(email: "testing@testing.com", password: "testing", password_confirmation: "testing", service_list: "hbo, netflix")}
		let(:hidden_show) { UserPreference.create!(user_id: user.id, imdb_id: "123tests") }
		let(:game){Media.create!(imdb_id: "testing123", service_list: "hbo", platform_list: "shows", run_time: 50, actor_list: "Cersei, Arya, Brienne", rating: 100, genre_list: "Drama")}
		let(:game_json) { [game].to_json(:include => [:genres, :services, :actors], methods: :genre_icons)}
		let(:hoc) {Media.create!(imdb_id: "testing321", service_list: "netflix", platform_list: "shows", run_time: 70, actor_list: "Frank, Claire", rating: 90, genre_list: "Comedy")}
		let(:all_movies) {[game, hoc].to_json(:include => [:genres, :services, :actors], methods: :genre_icons)}
		let(:hoc_json) { [hoc].to_json(:include => [:genres, :services, :actors], methods: :genre_icons)}

		before (:each) do
			allow_any_instance_of(SearchController).to receive(:current_user).and_return(user)
		end

		it "search for '60 minutes' gets a successful response" do
			get :search, :query => 'I have 60 minutes', :format => 'json'
			expect(response).to be_success
		end


		it "search for '60 minutes' returns one movie" do
			game
			post :search, :query => "60 minutes", :format => 'json'
			expect(response.body).to eq(game_json)
		end

		it "search for '80 minutes' returns 2 movies" do
			all_movies
			get :search, :query => "80 minutes", :format => 'json'
			expect(response.body).to eq(all_movies)
		end

		it "search for '20 minutes' returns no movies" do
			get :search, :query => "20 minutes", :format => 'json'
			expect(response.body).to eq("{\"success\":false,\"error\":\"20 minutes\"}")
		end

		it "search for 'drama' returns one movie" do
			all_movies
			get :search, :query => "Drama", :format => 'json'
			expect(response.body).to eq(game_json)
		end

		it "search for '80 minutes and comedy' returns one movie" do
			hoc
			get :search, :query => "80 minutes and comedy", :format => 'json'
			expect(response.body).to eq(hoc_json)
		end

		it "search for Frank returns one movie" do
			hoc
			get(:search, :query => "80 minutes for Frank", :format => 'json')
			expect(response.body).to eq(hoc_json)
		end

		it "search for Jim returns zero results" do
			all_movies
			get(:search,
					:query => "30 minutes for jim",
					:format => 'json')
			expect(response.body).to_not eq(all_movies)
		end

		it "specific search actors and genres passes appropriate results" do
			all_movies
			hoc
			get(:search, :query => "I have frank and COMEDY", :format => 'json')
			expect(response.body).to eq(hoc_json)
		end

		it "search for exact title" do
      all_movies
      hoc
      hoc_json
      get :search, :query => "House of Cards", :format => 'json'
      expect(response.body).to eq(hoc_json)
    end

	end

end
