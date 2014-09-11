require 'union'

class Media < ActiveRecord::Base
	include ActiveRecord::UnionScope

	attr_accessor :current_user

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

	def genre_icons
		list = self.genre_list.map do |genre|
			case genre
			when "News", "Reality-Tv", "Talk-Show", "Game-Show"
				"News"
			when "War", "Western"
				"War"
			when "History", "Documentary"
				"History"
			when "Crime", "Film-Noir"
				"Crime"
			else
				genre	
			end
		end
		return list.uniq.shift(3)
	end

	def service_icons
		return self.service_list & User.current.service_list
	end

	def title_rating
		if self.platform_list.to_s == "shows"
			return "IMDB"
		else
			return "Rotten Tomatoes"		
		end
	end

	 def self.actors_regex
    @actor_list ||= Media.actor_counts.pluck(:name).map(&:downcase)
    Regexp.union(@actor_list)
  end

  def self.genres_regex
    @genre_list ||= Media.genre_counts.pluck(:name).map(&:downcase)
    Regexp.union(@genre_list)
  end

  def self.titles_regex
    @titles ||= Media.pluck(:title).map(&:downcase)
    Regexp.union(@titles)
  end


end
