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

  def check_search_minutes
    minutes = /\d+/

    run_time = minutes.match(params_query)
    
    if minutes.match(params_query) != nil
      run_time = run_time[0].to_i
    end  
  end

  def check_search_genre
    genres = ["comedy", "drama", "science fiction", "horror", "romance", "sci-fi", "action"]
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
