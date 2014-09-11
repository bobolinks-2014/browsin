class SearchResultPresenter
	def initialize(media)
		@media = media
	end

	def to_hash
		{
			imdb_id: @media.imdb_id,
			actors: actors,
			rating: @media.rating,
			genre_icons: @media.genre_icons,
			service_icons: @media.service_icons,
			rating_source: @media.rating_source,
			synopsis: @media.synopsis,
			run_time: @media.run_time,
			title: @media.title
		}
	end

	def actors
		@media.actors.map do |actor|
			{name: actor.name}
		end
	end
end