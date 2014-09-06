class UsersController < ApplicationController

  def create
    @user = User.create(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
    if @user.save
      session[:current_user_id] = @user.id
      @user.add_service_list(params[:services])
      render :json => {success: true, user: @user.email}
    else
      puts @user.errors.full_messages
      render :json => {success: false, error: @user.errors.full_messages}
    end
  end

end
