require 'net/http'
require 'json'

class OMDBParser
  def self.make_omdb_calls(file)
    file.each do |id| #1500 times
      response = Net::HTTP.get("http://www.omdbapi.com/?i=#{id.imdb_id}")
      hashed = JSON.parse(response)
      omdb_collection = []
      omdb_data = {
        imdb_id: imdb_id,
        rt_id: rt_id
        title: hashed["Title"],
        runtime: hashed["Runtime"],
        genre_list: hashed["Genre"],
        actor_list: hashed["Actors"],
        synopsis: hashed["Plot"],
        type: hashed["Type"],
        if type != ["Movie"]
          imdb_rating: hashed["imdbRating"]
        end
      omdb_collection << omdb_data
    end
    }
  end

  def self.update_media
    Media.find_by(imdb_id).update(omdb_data)
    pass_to_rt = []
    omdb_collection.map do |omdb_data|
    if omdb_data.key(nil)
      omdb_data.shift
      pass_to_rt << omdb_data
      omdb_data.shift
    end
  end
end
