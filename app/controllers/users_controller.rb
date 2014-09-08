class UsersController < ApplicationController

  def create
    @user = User.create(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation], service_list: params[:services].values.flatten.join(","))
    if @user.save
      session[:current_user_id] = @user.id
      render :json => {success: true, user: @user.email}
    else
      puts @user.errors.full_messages
      render :json => {success: false, error: @user.errors.full_messages}
    end
  end

  def show
    render :json current_user, except: [:email, :password], include: [:service_list, :hidden_media], 
  end

  def edit
    if user_signed_in?
      current_user.update(service_list: params[:service_list])
      render :json => {success: true}
    else
      render :json => {success: false}
    end
  end

  def add
    preference = current_user.hidden_media.find_by_imdb_id(params[:item_id])
    preference.update(view_status: "show")
    render :json => {success: true}
  end

  def remove 
    UserPreference.create(user_id: current_user.id, media_id: params[:id], view_status: "hidden")
    render json: {success: true}
  end
end
