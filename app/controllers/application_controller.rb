class ApplicationController < ActionController::Base

	before_filter :set_current_user

	def set_current_user
		User.current = current_user
	end
  
  protected
  
  def user_signed_in?
    session[:current_user_id] != nil
  end
  
  def current_user
    @user ||= User.find(session[:current_user_id]) if user_signed_in?
  end

	def current_user_services
    current_user.service_list
  end

  def find_media(matcher)
      current_user_media.tagged_with(matcher).order('rating DESC, title ASC').limit(25)
  end

  def top_list
    current_user_media.order('rating DESC, title ASC').limit(25)
  end

  def find_results
    get_matches
    if is_number? && is_only_number?
      movies = current_user_media.where("run_time <= #{runtime_search}")
    elsif is_number?
      movies = current_user_media.where("run_time <= #{runtime_search}").tagged_with(@matches)
    else
      movies = current_user_media.tagged_with(@matches)
    end
    @movies = movies.order('rating DESC, title ASC').limit(25)
  end

  def current_user_media
    Media.tagged_with(current_user.service_list, :any => true).where.not(imdb_id: hidden_media)
  end

  def hidden_media
    current_user.hidden_media.pluck(:imdb_id)
  end

  def re_actors
    @actor_list ||= Media.actor_counts.pluck(:name).map(&:downcase)
    Regexp.union(@actor_list)
  end

  def re_genres
    @genre_list ||= Media.genre_counts.pluck(:name).map(&:downcase)
    Regexp.union(@genre_list)
  end

  def get_matches
    m = params[:query].downcase.scan(/(\d+)|(#{re_actors})|(#{re_genres})/)
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

   def add_user_preference
    preference = UserPreference.where(user: current_user).find_by(imdb_id: params[:item_id])
    preference.update(view_status: "show")
  end

  def update_user_preference
    pref = UserPreference.where(user: current_user).find_by(imdb_id: params[:id])
    if pref.nil?
      UserPreference.create(user_id: current_user.id, imdb_id: params[:id], view_status: "hide")
    else
      pref.update(view_status: "hide")
    end
  end

  def service_icons
  	media = Media.find_by_
  end

  def placeholder_text
    p_text = ["I have 30 minutes for comedy", "I want to watch a Robin Williams comedy", "Make me cry for 120 minutes with Fried Green Tomatoes", "Die Hard. Yes!", "I like horror and thriller", "I have 60 minutes for comedy with John Oliver"]
    p_text.sample
  end

  helper_method :placeholder_text
  helper_method :user_signed_in?
  helper_method :current_user
end
