require 'net/http'
require 'json'

class OMDBParser
  def self.get_api_data(ids_titles, netflix)
    omdb_collection = []

    ids_titles.each do |id|
      api_data = fetch_response(id, netflix)
      if api_data["Response"] == "True"
        media_data = set_media_data(api_data, id, netflix)
        omdb_collection << media_data
      end
    end
    return omdb_collection
  end

  def self.update_media(imdb_data)
    imdb_data.each do |media|
      current_media = Media.find_by_imdb_id(media[:imdb_id])
      if current_media == nil
        create_media(media)
      else
        if media[:service_list] == ("netflix")
          current_media.service_list.add("netflix")
          current_media.save
        else
          media.delete(:imdb_id)
          current_media.update(media)
        end
      end
    end
  end

  private

  def self.fetch_response(id, netflix)
    uri = get_uri(id, netflix)
    response = Net::HTTP.get_response(uri)
    JSON.parse(response.body)
  end

  def self.get_uri(id, netflix)
    if netflix == true
      url = URI.encode("http://www.omdbapi.com/?t=#{id}&tomatoes=true")
      URI.parse(url)
    else
      URI("http://www.omdbapi.com/?i=#{id}&tomatoes=true")
    end
  end

  def self.set_media_data(api_data, id, netflix)
    media_data = { imdb_id: id,
      title: api_data["Title"],
      run_time: api_data["Runtime"],
      genre_list: api_data["Genre"],
      actor_list: api_data["Actors"],
      synopsis: api_data["Plot"],
      type: api_data["Type"]
    }
    media_data = check_netflix_data(api_data, media_data, netflix)
    check_movie_data(api_data, media_data)
  end

  def self.check_netflix_data(api_data, media_data, netflix)
    if netflix == true
      media_data.merge!(:imdb_id => api_data["imdbID"], :service_list => "netflix")
      if media_data[:type] == "movie"
        media_data.merge(:platform_list => "movie")
      else
        media_data.merge(:platform_list => "shows")
      end
    else
      media_data
    end
  end

  def self.check_movie_data(api_data, media_data)
    if media_data[:type] == "movie"
      media_data.merge!(:rating => api_data["tomatoUserMeter"])
    else
      imdb_rating = api_data["imdbRating"].to_f * 10
      media_data.merge!(:rating => imdb_rating)
    end
    media_data.delete(:type)
    media_data
  end

  def self.create_media(media)
    Media.create(media)
  end

end
