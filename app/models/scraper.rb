require 'open-uri'
require 'nokogiri'

class Scraper

	def self.get_netflix_data
		titles = []
		(1..30).each do |number|
			doc = Nokogiri::HTML(open("http://instantwatcher.com/titles/highest_rated/#{number}"))
			title_list = doc.css('#title-listing')
			all_titles = title_list.search('li > a:nth-child(2)').map { |x| x.text }
			titles << all_titles
		end
		clean_media(titles.flatten)
	end

	def self.clean_media(media_file)
		media_file.each do |media|
			media.gsub!(/[(:].*$/, "")
			media.strip!
		end
		media_file.uniq
	end
end