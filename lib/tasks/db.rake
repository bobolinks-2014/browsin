namespace :db do
  desc "seeds database with media from Guidebox, Netflix, IMDB & Rotten Tomatoes"
  task media: :environment do
    puts "fetching Guidebox API data..."
  	guidebox_data = GuideboxParser.get_api_data

    puts "creating new media..."
  	media_data = GuideboxParser.create_media(guidebox_data)
    puts Media.all.count.to_s + " total records..."

    puts "fetching IMDB API data..."
  	imdb_data = OMDBParser.get_api_data(media_data, false)

    puts "updating media with IMDB data..."
  	OMDBParser.update_media(imdb_data)

    puts "fetching Netflix data..."
    netflix_data = Scraper.get_netflix_data

    puts "fetching IMDB API data..."
    imdb_data = OMDBParser.get_api_data(netflix_data, true)

    puts "creating media with Netflix & IMDB data..."
    OMDBParser.update_media(imdb_data)
    puts Media.all.count.to_s + " total records..."

    puts "destroying incomplete media records..."
    Media.clear_incomplete_records
    puts Media.all.count.to_s + " total records..."    
  end
end
