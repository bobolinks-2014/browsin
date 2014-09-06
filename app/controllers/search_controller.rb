class SearchController < ApplicationController

  def search
    movies = Media.tagged_with(tag_key).tagged_with("show", on: :status, owned_by:current_user)
    if movies == []
      render json: {success: false, error: tag_key}
    else
      render json: movies, include: [:genres, :services, :actors]
    end
  end

  # def filter
  # receive json data and check for the minutes(number), genre, and actor/actress that is searched for

  # single regex to produce search groups
params_query = {query: "I have 30 minutes for comedy and Anthony Dale"}
params_query = params_query[:query].split.each {|x| x.capitalize!}.join(" ")

actor_list = Media.actor_counts.map{ |x| x.name }
genre_list = Media.genre_counts.map{ |x| x.name }

re_actors = Regexp.union(actor_list)
re_genres = Regexp.union(genre_list)

# matches_minutes = params_query.scan(/(\d+)/)
# matches_genre = params_query.scan(/(#{re_genres})/)
# matches_minutes_genre = params_query.scan(/(\d+)|(#{re_genres})/i)
# matches_actor = params_query.scan(/(#{re_actors})/)
matches = params_query.scan(/(\d+)|(#{re_actors})|(#{re_genres})/i)




  # set up 3 diff regexs and if they are true, set them to a variable
  def check_search_actor
    actor_regex =/([A-Z]([a-z]+|\.)(?:\s+[A-Z]([a-z]+|\.))*(?:\s+[a-z][a-z\-]+){0,2}\s+[A-Z]([a-z]+|\.))/

    actor = actor_regex.match(params_query)

    if actor_regex.match(params_query) != nil
      actor = actor[0]
    else
      raise "That person isn't famous enough. Look for someone else!"
    end
  end

  # Need to compare actor against acts_as_taggable_on actor_list

  def check_search_minutes
    minutes = /\d+/

    run_time = minutes.match(params_query)

    if minutes.match(params_query) != nil
      run_time = run_time[0].to_i
    end
  end

  def check_search_genre
    genres = ["Animation", "History", "Family", "Romance", "Documentary", "Mystery", "Game-Show", "Thriller", "Fantasy", "Sport", "Reality-TV", "Talk-Show", "Western", "Musical", "News", "Music", "Adventure", "Comedy", "War", "Crime", "Action", "Horror", "Biography", "Sci-Fi", "Drama"]
    params_query.split.each do |word|
      if genres.include?(word.downcase)
        genre = word
      end
    end
  end


  private

  def search_value
    params.keys[0]
  end

  def tag_key
    params.values[0]
  end

  def params_query
    params[:query]
  end
end
