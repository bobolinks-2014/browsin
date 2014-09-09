require 'rails_helper'

RSpec.describe Media, :type => :model do
	let(:media) { Media.new(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", run_time: 55, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 99) }
	
	it "should have an IMDB id of '123test'" do
		expect(media.imdb_id).to eq("123test")
	end

	it "should have a genre called 'drama'" do
		expect(media.genre_list.to_s).to eq("drama")
	end

	it "should have a service called 'netflix'" do
		expect(media.service_list.to_s).to eq("netflix")
	end

	it "should have a platform of 'movie'" do
		expect(media.platform_list.to_s).to eq("movie")
	end

	it "should have an actor named 'John Wayne'" do
		expect(media.actor_list.to_s).to eq("John Wayne")
	end

	it "should have a run-time of '55' minutes" do
			expect(media.run_time).to eq(55)
		end
	
	it "should have a synopsis: 'A ruthless cowboy moves to a street with a lawless group of characters'" do
			expect(media.synopsis).to eq("A ruthless cowboy moves to a street with a lawless group of characters")
		end
	
	it "should have a title of 'Sesame Street'" do
			expect(media.title).to eq("Seseame Street")
		end
	
	it "should have a rating of '99'" do
			expect(media.rating).to eq(99)	
		end

	it "should clear media with a rating of '0'" do
			Media.create!(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", run_time: 55, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 0)
			expect{Media.clear_incomplete_records}.to change{Media.count}.from(1).to(0)
	end

	it "should clear media with a runtime of '0' minutes" do
			Media.create!(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", run_time: 0, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 90)
			expect{Media.clear_incomplete_records}.to change{Media.count}.from(1).to(0)
	end

	it "should only return 'news' when media has 'news' and 'relaity-tv' genres" do
		media1 = Media.create(imdb_id: "123test", genre_list: ["News", "Reality-Tv"] , service_list: "netflix", platform_list: "movie")
		expect(media1.genre_icons).to eq(["News"])
	end

	it "should only return 'war' when genres include 'war' and 'western'" do
		media1 = Media.create(imdb_id: "123test", genre_list: ["War", "Western"] , service_list: "netflix", platform_list: "movie")
		expect(media1.genre_icons).to eq(["War"])
	end

	it "should only return 'history' when genres include 'history' and 'documentary'" do
		media1 = Media.create(imdb_id: "123test", genre_list: ["History", "Documentary"] , service_list: "netflix", platform_list: "movie")
		expect(media1.genre_icons).to eq(["History"])
	end

	it "genre list should return 'sci-fi' and 'drama" do
		media1 = Media.create(imdb_id: "123test", genre_list: ["Sci-Fi", "Drama","History","Sport","Family","Music","Adventure","Fantasy","Biography","Romance","Thriller","Horror","Comedy","Mystery","Animation","Action","Crime"] , service_list: "netflix", platform_list: "movie")
		expect(media1.genre_icons).to eq(["Sci-Fi", "Drama","History","Sport","Family","Music","Adventure","Fantasy","Biography","Romance","Thriller","Horror","Comedy","Mystery","Animation","Action","Crime"])
	end
		it "should return empty array when genres include 'silly-show'"do
		media1 = Media.create(imdb_id: "123test", genre_list: ["silly-show"] , service_list: "netflix", platform_list: "movie")
		expect(media1.genre_icons).to eq([])
	end
end
