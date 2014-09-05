require 'net/http'
require 'json'

class OMDBParser
  def self.get_uri
    "http://www.omdbapi.com/?i=#{@imdb_id}"
  end

  def self.get_omdb_json
    response = Net::HTTP.get(get_uri)
    hashed = JSON.parse(response)
    omdb_data = {
      title: hashed["Title"],
      runtime: hashed["Runtime"],
      genre_list: hashed["Genre"],
      actor_list: hashed["Actors"],
      synopsis: hashed["Plot"],
      # type: hashed["Type"],  **Benchmark
      # if type != ["Movie"]
      imdb_rating: hashed["imdbRating"]
      # end
    }
  end
end
