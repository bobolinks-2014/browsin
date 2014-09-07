require 'rails_helper'

RSpec.describe Media, :type => :model do
	let(:media) { Media.new(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", status_list: "show", run_time: 55, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 99) }

	it "should have an IMDB id" do
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

	it "should have a status of 'show'" do
		expect(media.status_list.to_s).to eq("show")
	end
	
	it "should have a field of 'run_time'" do
			expect(media.run_time).to eq(55)
		end
	
	it "should have a field of 'synopsis'" do
			expect(media.synopsis).to eq("A ruthless cowboy moves to a street with a lawless group of characters")
		end
	
	it "should have a field of 'title'" do
			expect(media.title).to eq("Seseame Street")
		end
	
	it "should have a field of 'rating'" do
			expect(media.rating).to eq(99)	
		end

	it "should clear incomplete records" do
			Media.create(imdb_id: "123test", genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", status_list: "show", run_time: 55, synopsis: "A ruthless cowboy moves to a street with a lawless group of characters", title: "Seseame Street", rating: 0)
			expect(Media.count).to eq(1)
			Media.clear_incomplete_records
			expect(Media.count).to eq(0)
	end

end
