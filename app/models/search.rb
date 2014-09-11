class Search
	
	def self.find_results(user, query)
    get_matches(query)
    if is_number? && is_only_number?
      movies = user.media.where("run_time <= #{runtime_search}")
    elsif is_number?
      movies = user.media.where("run_time <= #{runtime_search}").tagged_with(@matches)
    else
      movies = Media.union_scope(user.media.where(generate_matches(:title, @matches)),
        user.media.tagged_with(@matches))
    end
    {movies: movies.order('rating DESC, title ASC').limit(25), matches: @matches}
  end

	def self.generate_matches(field, matches)
    matches.map {|m| "media.#{field} ILIKE '%#{m}%'"}.join(" OR ")
  end

  def self.get_matches(query)
    m = query.downcase.scan(/(\d+)|(#{Media.titles_regex})|(#{Media.actors_regex})|(#{Media.genres_regex})/)
    @matches = m.flatten.compact.sort
		@matches.include?('m') ? @matches.delete_at(@matches.index('m')) : @matches
		return @matches
  end

  def self.is_number?
    @matches[0].to_i > 0
  end

  def self.is_only_number?
    @matches.length == 1
  end

  def self.runtime_search
    @matches.shift.to_i
  end

  def self.top_list(user)
    user.media.order('rating DESC, title ASC').limit(25)
  end

  def self.find_media(user, matches)
     user.media.tagged_with(matches).order('rating DESC, title ASC').limit(25)
  end
end