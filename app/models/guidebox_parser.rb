require 'json'
require 'retriable'
require 'net/http'

class GuideboxParser

	def self.get_api_data
		all_platforms = ['shows', 'movie']
		all_services = ['hbo', 'hulu_plus', 'hulu_free']
		guidebox_data = []

		all_platforms.each do |platform|
			all_services.each do |service|
				uri = URI("http://api-public.guidebox.com/v1.43/json/#{GUIDEBOX_API_KEY}/#{platform}/all/0/250/#{service}/all")
				api_data = self.get_http_response(uri)
				parsed_file = self.parse_json_file(api_data.body)
				final_media = self.clean_media(parsed_file, platform, service)
				guidebox_data << final_media
			end
		end
		return guidebox_data.flatten
	end

	def self.get_http_response(uri)
		Retriable.retriable :on => StandardError, :tries => 3, :interval => 3 do
			Net::HTTP.start(uri.host, uri.port) do |http|
				request = Net::HTTP::Get.new uri
				response = http.request(request)
			end
		end
	end

	def self.parse_json_file(file)
		full_hash = JSON.parse(file)
		media_results = full_hash['results']
	end

	def self.clean_media(media_file, platform, service)
		media_file.each do |media|
			media.select! { |k,v| k == 'imdb' || k == 'imdb_id' }
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
			new_media = Media.new(media)
			if new_media.save
				imdb_data << media['imdb_id']
			elsif media['imdb_id'] != ""
				service = media['service_list']
				old_media = Media.find_by_imdb_id(media['imdb_id'])
				if !old_media.service_list.include?(service)
					old_media.service_list.add(service)
				end
			end
		end
		return imdb_data
	end

end

