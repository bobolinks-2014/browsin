class UserPreference < ActiveRecord::Base
	belongs_to :user
	belongs_to :media

	validates_presence_of :user_id, :media_id, :view_status
end
