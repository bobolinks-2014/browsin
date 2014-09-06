class SearchController < ApplicationController
  attr_accessor :matches

  def search
    movies = Media.where("run_time <= #{runtime_search}").tagged_with(@matches).tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
    if movies == []
      render json: {success: false, error: params_query}
    else
      render json: movies, include: [:genres, :services, :actors]
    end
  end

  def re_actors
    @actor_list ||= Media.actor_counts.map{ |x| x.name.downcase }
    Regexp.union(@actor_list)
  end

  def re_genres
    @genre_list ||= Media.genre_counts.map{ |x| x.name.downcase }
    Regexp.union(@genre_list)
  end

  # single regex to produce search groups
  def get_matches
    query = params_query.split.each {|x| x.downcase!}.join(" ")
    m = params_query.scan(/(\d+)|(#{re_actors})|(#{re_genres})/i)
    m.flatten!.compact!.sort!
  end

  def runtime_search
    @matches = get_matches
    @matches.shift.to_i
  end

  # Need to compare actor against acts_as_taggable_on actor_list

  private

  def params_query
    params[:query]
  end
end
