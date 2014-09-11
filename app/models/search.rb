class Search
	
	def self.find_results(user, query)
    get_matches(query)

    if is_number?
			movies = user.media.where("run_time <= #{runtime_search}")
    	if is_only_number?
      	movies.tagged_with(@all_matches)
      end
    else
      movies = Media.union_scope(user.media.where(generate_matches(:title, @all_matches)),
        user.media.tagged_with(@all_matches))
    end
    {movies: movies.order('rating DESC, title ASC').limit(25), matches: @all_matches}
  end

  private

  def self.get_matches(query)
    word_matches = query.downcase.scan(/(\d+)|(#{Media.titles_regex})|(#{Media.actors_regex})|(#{Media.genres_regex})/)
    @all_matches = word_matches.flatten.compact.sort
		@all_matches.include?('m') ? @all_matches.delete("m") : @all_matches
  end

  def self.is_number?
    @all_matches[0].to_i > 0
  end

  def self.is_only_number?
    @all_matches.length == 1
  end

  def self.runtime_search
    @all_matches.shift.to_i
  end

  def self.top_list(user)
    user.media.order('rating DESC, title ASC').limit(25)
  end

  def self.find_media(user, matches)
     user.media.tagged_with(matches).order('rating DESC, title ASC').limit(25)
  end

  def self.generate_matches(field, matches)
    matches.map {|m| "media.#{field} ILIKE '%#{m}%'"}.join(" OR ")
  end

end