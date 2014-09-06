namespace :db do
  desc "seeds database with media from Guidebox, IMDB and Rotten Tomatoes"
  task media: :environment do
    puts "fetching Guidebox API data"
  	guidebox_data = GuideboxParser.get_api_data
    puts "creating new media"
  	imdb_ids = GuideboxParser.create_media(guidebox_data)
    puts "fetching IMDB API data"
  	imdb_data = OMDBParser.get_api_data(imdb_ids)
    puts "updating media with IMDB data"
  	OMDBParser.update_media(imdb_data)
  	# Discard media with any empty fields
  end

end
