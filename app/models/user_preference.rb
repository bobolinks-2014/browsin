class UserPreference < ActiveRecord::Base
	belongs_to :user
	belongs_to :media, foreign_key: 'imdb_id', primary_key: 'imdb_id'

	validates_presence_of :user_id, :imdb_id, :view_status
end
