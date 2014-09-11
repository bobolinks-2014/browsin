class UserConfigPresenter
	def initialize(user)
		@user = user
	end

	def to_hash
		{
			id: @user.id,
			email: @user.email,
			service_list: @user.service_list,
			hidden_media: hidden_media
		}
	end

	def hidden_media
		@user.hidden_media.map do |media|
			{
				id: media.id,
				imdb_id: media.imdb_id,
				title: media.title,
				rating: media.rating
			}
		end
	end
end