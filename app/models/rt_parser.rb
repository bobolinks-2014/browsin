require 'net/http'
require 'json'

class RTParser
  def self.make_rt_calls(file)
    file.each do |id|
      response = Net::HTTP.get("http://api.rottentomatoes.com/api/public/v1.0/movies/#{id.rt_id}.json?apikey=[your_api_key]")
      hashed = JSON.parse(response)
      rt_collection = []
      rt_data = {
        rt_id: rt_id
        title: hashed["title"],
        runtime: hashed["runtime"],
        genre_list: hashed["genres"],
        actor_list: hashed["abriged_cast"]["name"],
        synopsis: hashed["synopsis"]}
      rt_collection << rt_data
    end
    }
  end

  def self.update_media
    Media.find_by(imdb_id).update(rt_data)
    pass_to_rt = []
    rt_collection.map do |rt_data|
      if rt_data.key(nil)
        2.times {rt_data.shift}
        rt_data
      end
    end
  end
end
