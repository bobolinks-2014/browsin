require 'rails_helper'

describe SearchController do

	describe 'search route' do
		let(:user) {User.create!(email: "testing@testing.com", password: "testing", password_confirmation: "testing", service_list: "hbo, netflix")}
		let(:hidden_show) { UserPreference.create!(user_id: user.id, imdb_id: "123tests") }
		let(:game){Media.create!(imdb_id: "testing123", service_list: "hbo", platform_list: "shows", run_time: 50, actor_list: "Cersei, Arya, Brienne", rating: 100, genre_list: "Drama")}
		let(:game_json) { [game].to_json(:include => [:genres, :services, :actors])}
		let(:hoc) {Media.create!(imdb_id: "testing321", service_list: "netflix", platform_list: "shows", run_time: 70, actor_list: "Frank, Claire", rating: 90, genre_list: "Comedy")}
		let(:all_movies) {[game, hoc].to_json(:include => [:genres, :services, :actors])}
		let(:hoc_json) { [hoc].to_json(:include => [:genres, :services, :actors])}

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
					:query => "30 minutes for Jim",
					:format => 'json')
			expect(response.body).should_not eq(all_movies)
		end

		it "specific search including time, actors and genres passes appropriate results" do
			all_movies
			hoc
			get(:search, :query => "I have 80 minutes for Frank and COMEDY", :format => 'json')
		end
	end

	describe 'remove route' do
		before(:each) do
			user = User.create!(email: "testing@testing.com", password: "testing", password_confirmation: "testing", service_list: "hbo")
			allow(got).to receive(:runtime_search){50}
			allow(hoc).to receive(:runtime_search){50}
			allow(SearchController).to receive(:current_user){user}
			allow(UserPreference).to receive(:create){preference}

			# allow(SearchController).to receive('UserPreference.create')
		end
# testing remove method
		it "user is able to hide a show from their list" do
			put(:remove,
					:id => hoc.id,
					:format => 'json')
			media = Media.find(hoc.id)
			expect(media.status).to eq("hide")
		end
# testing top method --> tested in feature testing

		# it "clicking the play button give the top 25 rated media items" do
		# 	get(:top,
		# 			:query => ,
		# 			:format => 'json')
		# 	expect(response.body).to eq(all_movies)
		# end

		# it 'clicking play after removing a show does not show that item' do
		# 	put(:remove,
		# 			#remove got
		# 			:query => ,
		# 			:format => 'json')

		# 	get(:search,
		# 			:query => ,
		# 			:format => 'json')
		# 	expect(response.body).to eq(hoc_json)

		# end

# testing find method
		it 'finding comedy returns hoc' do
			get(:find,
					:lookup => "comedy",
					:format => 'json')
			expect(response.body).to eq(hoc_json)
		end

	end
end


# 		it "a search for Frank or Arya returns got and hoc doesn't compute" do
# 			get(:search,
# 					:query => "60 minutes for Frank and Arya",
# 					:format => 'json')
# 			expect(response.body).should_not eq(all_movies)
# 		end
# 	end

# 	describe 'remove route' do
# 		before(:each) do
# 			# user.tag(got, with: :"show", on: :status)
# 			user.hidden_media.count == 0
# 			allow(got).to receive(:runtime_search){50}
# 			allow(hoc).to receive(:runtime_search){50}
# 			# allow(SearchController).to receive(:current_user){user}
# 			allow(SearchController).to receive_message_chain('current_user.id'){user.id}
# 		end
# # testing remove method
# 		it "user is able to hide a show from their list" do
# 			arrow = Media.create!(imdb_id: "testing32", service_list: "netflix", platform_list: "shows", run_time: 50, actor_list: "Frank, Claire", rating: 90, genre_list: "Comedy")

# 			patch(:remove,
# 					:id => arrow.id,
# 					:format => 'json')

# 			expect(user.hidden_media.count).to eq(1)
# 			# media = Media.find(hoc.id)
# 			# expect(media.status).to eq("hide")
# 		end
# # testing top method --> tested in feature testing

# 		# it "clicking the play button give the top 25 rated media items" do
# 		# 	get(:top,
# 		# 			:query => ,
# 		# 			:format => 'json')
# 		# 	expect(response.body).to eq(all_movies)
# 		# end

# 		# it 'clicking play after removing a show does not show that item' do
# 		# 	put(:remove,
# 		# 			#remove got
# 		# 			:query => ,
# 		# 			:format => 'json')

# 		# 	get(:search,
# 		# 			:query => ,
# 		# 			:format => 'json')
# 		# 	expect(response.body).to eq(hoc_json)

# 		# end

# # testing find method
# 		it 'finding comedy returns hoc' do
# 			get(:find,
# 					:lookup => "comedy",
# 					:format => 'json')
# 			expect(response.body).to eq(hoc_json)
# 		end
# 	end
# end
