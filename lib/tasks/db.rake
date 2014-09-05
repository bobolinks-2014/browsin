namespace :db do
  desc "seeds database with media from Guidebox, IMDB and Rotten Tomatoes"
  task media: :environment do
  	guidebox_data = GuideboxParser.get_api_data
  	imdb_rt_ids = GuideboxParser.create_media(guidebox_data)
  	# imdb_data = OMDBParser.get_api_data(imdb_rt_ids)
  	# rt_ids = OMDBParser.update_media(imdb_data)
  	# rt_data = RTParser.get_api_data(rt_ids)
  	# RTParser.update_media(rt_data)
  	
  	# Discard media with any empty fields
  end

end
