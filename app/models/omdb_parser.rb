require 'net/http'
require 'json'

class OMDBParser
  def self.get_api_data(imdb_ids)
    omdb_collection = []

    imdb_ids.each do |id| #1500 times
      uri = URI("http://www.omdbapi.com/?i=#{id}&tomatoes=true")
      response = Net::HTTP.get_response(uri)
      hashed = JSON.parse(response.body)

      omdb_data = { imdb_id: id,
                    title: hashed["Title"],
                    run_time: hashed["Runtime"],
                    genre_list: hashed["Genre"],
                    actor_list: hashed["Actors"],
                    synopsis: hashed["Plot"],
                    type: hashed["Type"]
                  }

      if omdb_data[:type] == "movie"
        omdb_data.merge!(:rating => hashed["tomatoUserMeter"])
      else
        imdb_rating = hashed["imdbRating"].to_f * 10
        omdb_data.merge!(:rating => imdb_rating)
      end

      omdb_data.delete(:type)
      omdb_collection << omdb_data
    end
    return omdb_collection
  end

  def self.update_media(imdb_data)
    imdb_data.each do |media|
      current_media = Media.find_by_imdb_id(media[:imdb_id])
      media.delete(:imdb_id)
      current_media.update(media)
    end
  end

end
