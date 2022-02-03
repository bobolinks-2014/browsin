require 'json'
require 'retriable'
require 'net/http'

class TmdbParser

  def self.get_api_data
    tmdb_data = []
    page = 1
    total_page_count = 1000

    while page < total_page_count
      result = Tmdb::Movie.popular({ page: page })
      result.total_pages < 1000 ? total_page_count = result.toal_pages : total_page_count = 1000
      total_page_count = result.total_pages

      result.results.each { |movie|
        movie_info = get_movie_data(movie)
        if Media.find_by_imdb_id(movie_info['imdb_id'])
          next
        end

        watch_providers = get_watch_providers(movie)
        watch_providers = watch_providers['US'] || { flatrate: [{}] }
        credits = get_movie_info('credits', movie)

        if watch_providers['flatrate']
          movie_result = {
            imdb_id: movie_info['imdb_id'],
            title: movie['title'],
            synopsis: movie_info['overview'],
            run_time: movie_info['runtime'],
            genre_list: movie_info['genres'].map { |k, v| k['name'] },
            service_list: watch_providers['flatrate'].map { |k, v| k['provider_name'] },
            platform_list: 'movie',
            actor_list: credits['cast'].map{|cast_member| cast_member['name']},
            rating: movie['vote_average']
          }

          create_media_item([], movie_result)
        end
      }

      page = result.page + 1
    end

    return tmdb_data.flatten
  end

  def self.parse_json_file(file)
    JSON.parse(file)
  end

  def self.clean_media(media_file, platform, service)
    media_file.each do |media|
      media.select! { |k, v| k == 'imdb' || k == 'imdb_id' }
      media.merge!('platform_list' => platform, 'service_list' => service)
    end

    if platform == 'movie'
      media_file.each do |media|
        imdb_id = media.delete("imdb")
        media.merge!('imdb_id' => imdb_id)
      end
    end
    return media_file
  end

  def self.create_media(media_results)
    imdb_data = []
    media_results.each do |media|
      create_media_item(imdb_data, media)
    end
    return imdb_data
  end

  private

  def self.get_movie_data(movie)
    uri = URI("https://api.themoviedb.org/3/movie/#{movie.id}?api_key=#{TMDB_API_KEY}")
    api_data = Net::HTTP.get_response(uri)
    parsed_file = self.parse_json_file(api_data.body)
    parsed_file
  end

  def self.get_movie_info(type, movie)
    uri = URI("https://api.themoviedb.org/3/movie/#{movie.id}/#{type}?api_key=#{TMDB_API_KEY}")
    api_data = Net::HTTP.get_response(uri)
    parsed_file = self.parse_json_file(api_data.body)
    parsed_file
  end

  def self.get_watch_providers(movie)
    uri = URI("https://api.themoviedb.org/3/movie/#{movie.id}/watch/providers?api_key=#{TMDB_API_KEY}")
    api_data = Net::HTTP.get_response(uri)
    parsed_file = self.parse_json_file(api_data.body)
    parsed_file['results']
  end

  def self.create_media_item(imdb_data, media)
    new_media = Media.new(media)
    if new_media.save
      imdb_data << media['imdb_id']
    end
    new_media
  end

end

