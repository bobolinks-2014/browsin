class Media < ActiveRecord::Base
	acts_as_taggable_on :services, :genres, :platforms, :actors, :statuses

	# validates presence of tags services and platform (cant be empty)
	validates_presence_of :imdb_id, :service_list, :platform_list
	validates_uniqueness_of :imdb_id

	def self.clear_incomplete_records
		self.where(rating: 0).destroy_all
		self.where(run_time: 0).destroy_all		
		self.where(rating: nil).destroy_all
		self.where(run_time: 0).destroy_all
	end


end
