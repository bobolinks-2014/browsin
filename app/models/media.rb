class Media < ActiveRecord::Base
	acts_as_taggable_on :services, :genres, :platforms, :actors, :statuses
end
