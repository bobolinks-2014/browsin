class SearchController < ApplicationController

  def search
    movies = Media.tagged_with(tags_search).where("run_time <= #{runtime_search}").tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
    if movies == []
      render json: {success: false, error: tag_key}
    else
      render json: movies, include: [:genres, :services, :actors]
    end
  end

  def re_actors
    actor_list = Media.actor_counts.map{ |x| x.name }
    Regexp.union(actor_list)
  end

  def re_genres
    genre_list = Media.genre_counts.map{ |x| x.name }
    Regexp.union(genre_list)
  end

  # single regex to produce search groups
  def get_matches
    query = params_query[:query].split.each {|x| x.capitalize!}.join(" ")
    matches = params_query.scan(/(\d+)|(#{re_actors})|(#{re_genres})/i)
    matches.flatten!.compact!.sort!
  end

  def runtime_search
    matches = get_matches
    matches[0].to_i
  end

  def tags_search
    matches = get_matches
    matches.shift
  end

  # Need to compare actor against acts_as_taggable_on actor_list

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
