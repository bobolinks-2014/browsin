class Media < ActiveRecord::Base
	acts_as_taggable_on :services, :genres, :platforms, :actors, :statuses

	# validates presence of tags services and platform (cant be empty)
	validates_presence_of :imdb_id, :service_list, :platform_list
	validates_uniqueness_of :imdb_id

	def self.clear_incomplete_records
		self.where(rating: 0).destroy_all
		self.where(run_time: 0).destroy_all		
	end


# create method that iterates through all genres that are tagged on a Media item and check if 
# 2 genres have the same icon. If yes, only display the icon once with a / in the middle of them. 
# ex: "talk show/ news" should have 1 icon. 
	def genre_icons
			genre_array =[]
		self.genre_list.each do |genre|
			case genre
			when "News"
				genre_array <<  genre
			when "Reality-Tv"
			when "Talk-Show"
			when "Game-Show"	
			when "War"
				genre_array <<  genre
			when "Western"
			when "History"
				genre_array <<  genre
			when "Documentary"
			when "Sci-Fi"
				genre_array <<  genre
			when "Drama"
				genre_array <<  genre
			when "History"
				genre_array <<  genre
			when "Sport"
				genre_array <<  genre
			when "Family"
				genre_array <<  genre
			when "Music"
				genre_array <<  genre
			when "Adventure"
				genre_array <<  genre
			when "Fantasy"
				genre_array <<  genre
			when "Biography"
				genre_array <<  genre
			when "Romance"
				genre_array <<  genre
			when "Thriller"
				genre_array <<  genre
			when "Horror"
				genre_array <<  genre
			when "Comedy"
				genre_array <<  genre
			when "Mystery"
				genre_array <<  genre
			when "Animation"
				genre_array <<  genre
			when "Action"
				genre_array <<  genre
			when "Crime"
				genre_array <<  genre
			else
				"Not a genre"			
			end
		end
			genre_array
	end
end
