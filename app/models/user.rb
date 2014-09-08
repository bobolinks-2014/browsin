class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :email, :on => :create
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, :length => { :minimum => 6 }
  
  acts_as_taggable_on :services
  acts_as_tagger
  
  def add_service_list(services)
    Media.tagged_with(services.values.flatten, any: true).each do |media| 
      self.tag(media, with: :"show", on: :status)
    end
  end

end
