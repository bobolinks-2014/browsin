require 'net/http'
require 'json'

class OMDBParser
  def self.get_api_data(media_data, netflix)
    omdb_collection = []

    media_data.each do |id|
      if netflix == true
        url = URI.encode("http://www.omdbapi.com/?t=#{id}&tomatoes=true")
        uri = URI.parse(url)
      else
        uri = URI("http://www.omdbapi.com/?i=#{id}&tomatoes=true")
      end
      
      response = Net::HTTP.get_response(uri)
      api_data = response.body

      hashed = JSON.parse(response.body)

      if hashed["Response"] == false
        break
      else 
        omdb_data = { imdb_id: id,
                      title: hashed["Title"],
                      run_time: hashed["Runtime"],
                      genre_list: hashed["Genre"],
                      actor_list: hashed["Actors"],
                      synopsis: hashed["Plot"],
                      type: hashed["Type"]
                    }
        if netflix == true 
          omdb_data.merge!(:imdb_id => hashed["imdbID"], :service_list => "netflix")
          if hashed["Type"] == "movie"
            omdb_data.merge!(:platform_list => "movie")
          else
            omdb_data.merge!(:platform_list => "shows")
          end
        end

        if omdb_data[:type] == "movie"
          omdb_data.merge!(:rating => hashed["tomatoUserMeter"])
        else
          imdb_rating = hashed["imdbRating"].to_f * 10
          omdb_data.merge!(:rating => imdb_rating)
        end
      end

      omdb_data.delete(:type)
      omdb_collection << omdb_data
    end
    return omdb_collection
  end

  def self.create_update_media(imdb_data)
    imdb_data.each do |media|
      current_media = Media.find_by_imdb_id(media[:imdb_id])
      if current_media == nil
        new_media = Media.new(media)
        if new_media.save
          break
        else
          old_media = Media.find_by_imdb_id(media[:title])
          old_media.service_list.add("netflix")
          old_media.save
        end
      else
        media.delete(:imdb_id)
        current_media.update(media)
      end
    end
  end

end
