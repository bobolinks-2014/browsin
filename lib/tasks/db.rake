namespace :db do
  desc "seeds database with media from Guidebox, Netflix, IMDB & Rotten Tomatoes"
  task media: :environment do
    puts "fetching Tmdb API data..."
    tmdb_data = TmdbParser.get_api_data

    puts "creating new media..."
  	# media_data = TmdbParser.create_media(tmdb_data)
    puts tmdb_data
    total_records

    # puts "fetching IMDB API data..."
  	# imdb_data = OMDBParser.get_api_data(media_data, false)
    #
    # puts "updating media with IMDB data..."
  	# OMDBParser.update_media(imdb_data)
    #
    # puts "fetching Netflix data..."
    # netflix_data = Scraper.get_netflix_data
    #
    # puts "fetching IMDB API data..."
    # imdb_data = OMDBParser.get_api_data(netflix_data, true)
    #
    # puts "creating media with Netflix & IMDB data..."
    # OMDBParser.update_media(imdb_data)
    total_records

    # puts "destroying incomplete media records..."
    # Media.clear_incomplete_records
    total_records
  end

  def total_records
    puts "#{Media.count.to_s} total records..."
  end
end
