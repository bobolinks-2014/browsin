require 'rails_helper'

describe SearchController do 
	let(:got) {Media.create!(imdb_id: "testing123", service_list: "hbo", platform_list: "shows", run_time: 50, actor_list: "Cersei, Arya, Brienne", rating: 100, genre_list: "Drama")}
	let(:got_json) {[got].to_json(:include => [:genres, :services, :actors])}
	let(:hoc) {Media.create!(imdb_id: "testing321", service_list: "netflix", platform_list: "shows", run_time: 50, actor_list: "Frank, Claire", rating: 90, genre_list: "Comedy")}
	let(:hoc_json) {[hoc].to_json(:include => [:genres, :services, :actors])}
	let(:all_movies) {[got, hoc].to_json(:include => [:genres, :services, :actors])}
	let(:user) {User.create!(email: "testing@testing.com", password: "testing", password_confirmation: "testing", service_list: "hbo")}
	let(:error) {{success: false, error: '20 minutes'}.to_json}
	let(:preference){UserPreference.create!(user_id: user.id, media_id: got.id, view_status: "show")}

	describe 'search route' do 
		before(:each) do
			allow(got).to receive(:runtime_search){50} 
			allow(hoc).to receive(:runtime_search){50} 
			allow(SearchController).to receive(:current_user){user}
			(SearchController).stub_chain('current_user.service_list').and_return(user.service_list)

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

		it "search for Frank returns one movie" do
			get(:search,
				:query => "60 minutes for Frank",
				:format => 'json')
			expect(response.body).to eq(hoc_json)
		end

		it "search for Jim returns zero results" do
			get(:search,
					:query => "30 minutes for Jim",
					:format => 'json')
			expect(response.body).should_not eq(all_movies)
		end

		it "a search for Frank or Arya returns got and hoc doesn't compute" do
			get(:search,
					:query => "60 minutes for Frank and Arya",
					:format => 'json')
			expect(response.body).should_not eq(all_movies)
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