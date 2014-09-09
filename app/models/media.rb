class Media < ActiveRecord::Base
  has_many :user_preferences, foreign_key: 'imdb_id', primary_key: 'imdb_id'
  has_many :hidden_users, -> {where 'user_preferences.view_status'=> "hide"}, through: :user_preferences, source: :user

	acts_as_taggable_on :services, :genres, :platforms, :actors

	validates_presence_of :imdb_id, :service_list, :platform_list
	validates_uniqueness_of :imdb_id

	def self.clear_incomplete_records
		self.where(rating: 0).destroy_all
		self.where(run_time: 0).destroy_all		
		self.where(rating: nil).destroy_all
		self.where(run_time: 0).destroy_all
	end
end
