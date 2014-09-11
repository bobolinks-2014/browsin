class UsersController < ApplicationController

  def create
    params[:user].merge!(service_list: params[:services].values.flatten.join(","))
    user = User.create(user_params)
    if user.save
      session[:current_user_id] = user.id
      render :json => {success: true, user: user.email}
    else
      render :json => {success: false, error: user.errors.full_messages}
    end
  end

  def show
    render :json => {user: current_user.as_json(include: :hidden_media, methods: :service_list)}
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :service_list)
  end

end
