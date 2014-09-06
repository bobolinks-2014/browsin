class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :email
  
  acts_as_taggable_on :services
  acts_as_tagger
  
  def add_service_list(services)
    Media.tagged_with(services.values.flatten, any: true).each do |media| 
      self.tag(media, with: :"show", on: :status)
    end
  end

end
