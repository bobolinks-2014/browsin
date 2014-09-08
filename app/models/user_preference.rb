class UserPreference < ActiveRecord::Base
	belongs_to :users
	belongs_to :media

	validates_presence_of :user_id, :media_id, :view_status
end
