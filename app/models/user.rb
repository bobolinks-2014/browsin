class User < ActiveRecord::Base
  has_many :user_preferences
  # has_many :hidden_media, -> {where view_status: "hidden"}, through: :user_preferences, source: :media
  has_many :hidden_media, through: :user_preferences, source: :media
  has_secure_password
  validates_presence_of :service_list, :password, :on => :create
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, :length => { :minimum => 6 }

  acts_as_taggable_on :services
  acts_as_tagger
end
