class UsersController < ApplicationController

  def create
    @user = User.create(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], service_list: params[:services].values.flatten.join(","))
    if @user.save
      session[:current_user_id] = @user.id
      render :json => {success: true, user: @user.email}
    else
      render :json => {success: false, error: @user.errors.full_messages}
    end
  end

  def show
    render :json => {user: current_user.as_json(include: :hidden_media, methods: :service_list)}
  end

  def update
    if user_signed_in?
      current_user.update_attribute('service_list', params[:service_list])
      render :json => {success: true}
    else
      render :json => {success: false}
    end
  end

  def add
    preference = UserPreference.where(user: current_user).find_by(imdb_id: params[:item_id])
    preference.update(view_status: "show")
    render :json => {success: true}
  end

  def remove 
    pref = UserPreference.where(user: current_user).find_by(imdb_id: params[:id])
    if pref.nil?
      UserPreference.create(user_id: current_user.id, imdb_id: params[:id], view_status: "hide")
    else
      pref.update(view_status: "hide")
    end

    render json: {success: true}
  end
end
