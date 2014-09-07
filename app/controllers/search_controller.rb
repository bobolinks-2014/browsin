class SearchController < ApplicationController
  attr_accessor :matches
  respond_to :json

  def search
    find_results
    if @movies == []
      render json: {success: false, error: params_query}
    else
      render json: @movies, include: [:genres, :services, :actors]
    end
  end
  
  def destroy
    puts params[:id]
    render json: {success: true}
  end
  
  # Need to compare actor against acts_as_taggable_on actor_list

  private

  def params_query
    params[:query].downcase
  end

  def find_results
    get_matches
    if is_number? && is_only_number?  
      @movies = Media.where("run_time <= #{runtime_search}").tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
    elsif is_number?
      @movies = Media.where("run_time <= #{runtime_search}").tagged_with(@matches).tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25) 
    else
      @movies = Media.tagged_with(@matches).tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
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
    m = params_query.scan(/(\d+)|(#{re_actors})|(#{re_genres})/i)
    @matches = m.flatten.compact.sort
  end

  def runtime_search
    #@matches = get_matches
    @matches.shift.to_i
  end

  def is_number?
    @matches[0].to_i > 0
  end
  
  def is_only_number?
    @matches.length == 1
  end
end
