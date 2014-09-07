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
  
  def remove 
    current_user.tag(Media.find(params[:id]), with: :"hide", on: :status)
    render json: {success: true}
  end
  
  def top
    if user_signed_in?
      @movies = top_list
      puts @movies[0].title
      render json: @movies, include: [:genres, :services, :actors]
    else
      render json: {success: false}
    end
  end


  def find
    render json: find_media(params[:lookup]), include: [:genres, :services, :actors]
  end
  # Need to compare actor against acts_as_taggable_on actor_list

  private

  def params_query
    params[:query].downcase
  end

  def top_list
    Media.tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
  end

  def find_results
    get_matches
    if is_number? && is_only_number?  
      @movies = Media.where("run_time <= #{runtime_search}").tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
    elsif is_number?
      @movies = Media.where("run_time <= #{runtime_search}").tagged_with(@matches).tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25) 
    else
      find_media(@matches)
    end
  end

  def find_media(matcher)
      @movies = Media.tagged_with(matcher).tagged_with("show", on: :status, owned_by:current_user).order('rating DESC').limit(25)
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
