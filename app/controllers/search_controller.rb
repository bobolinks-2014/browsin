class SearchController < ApplicationController
  attr_accessor :matches

  def search
    find_results
    if @movies == []
      render json: {success: false, error: params_query}
    else
      render json: @movies, include: [:genres, :services, :actors]
    end
  end
  
  def remove 
    UserPreference.create(user_id: current_user.id, media_id: params[:id], view_status: "hidden")
    render json: {success: true}
  end
  
  def top
    if user_signed_in?
      render json: top_list, include: [:genres, :services, :actors]
    else
      render json: {success: false}
    end
  end

  def find
    render json: find_media(params[:lookup]), include: [:genres, :services, :actors]
  end

  private

  def find_media(matcher)
      current_user_media.tagged_with(matcher).order('rating DESC, title ASC').limit(25)
  end

  def params_query
    params[:query].downcase
  end

  def top_list
    current_user_media.order('rating DESC, title ASC').limit(25)
  end

  def find_results
    get_matches
    if is_number? && is_only_number?  
      movies = current_user_media.where("run_time <= #{runtime_search}")
    elsif is_number?
      movies = current_user_media.tagged_with(@matches).where("run_time <= #{runtime_search}")
    else
      movies = current_user_media.tagged_with(@matches)
    end
    @movies = movies.order('rating DESC, title ASC').limit(25)
  end

  def current_user_media
    Media.tagged_with(current_user.service_list, :any => true).where.not(title: hidden_media)
  end

  def hidden_media
    current_user.hidden_media.pluck(:title)
  end

  def re_actors
    @actor_list ||= Media.actor_counts.map{ |x| x.name.downcase }
    Regexp.union(@actor_list)
  end

  def re_genres
    @genre_list ||= Media.genre_counts.map{ |x| x.name.downcase }
    Regexp.union(@genre_list)
  end

  def get_matches
    m = params_query.scan(/(\d+)|(#{re_actors})|(#{re_genres})/i)
    @matches = m.flatten.compact.sort
  end

  def runtime_search
    @matches.shift.to_i
  end

  def is_number?
    @matches[0].to_i > 0
  end
  
  def is_only_number?
    @matches.length == 1
  end 
end
