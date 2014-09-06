class Media < ActiveRecord::Base
	acts_as_taggable_on :services, :genres, :platforms, :actors, :statuses

	# validates presence of tags services and platform (cant be empty)
	validates_presence_of :imdb_id, :service_list, :platform_list
end
