require 'rails_helper'

RSpec.describe Media, :type => :model do
	let(:media) { Media.new(genre_list: "drama", service_list: "netflix", platform_list: "movie", actor_list: "John Wayne", status_list: "show") }

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
end
