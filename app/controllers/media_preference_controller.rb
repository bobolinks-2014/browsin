class MediaPreferenceController < ApplicationController

  def add
    preference = UserPreference.where(user: current_user).find_by(imdb_id: params[:item_id])
    preference.update(view_status: "show")
    render :json => {success: true}
  end

  def remove
    preference = UserPreference.where(user: current_user).find_by(imdb_id: params[:id])
    if preference.nil?
      UserPreference.create(user_id: current_user.id, imdb_id: params[:id], view_status: "hide")
    else
      preference.update(view_status: "hide")
    end
    	render json: {success: true}
  end

end