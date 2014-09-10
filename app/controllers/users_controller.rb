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
      p params[:service_list]
      current_user.update_attribute('service_list', params[:service_list])
      render :json => {success: true}
    else
      render :json => {success: false}
    end
  end

  def add
    add_user_preference
    render :json => {success: true}
  end

  def remove 
    update_user_preference
    render json: {success: true}
  end


end
