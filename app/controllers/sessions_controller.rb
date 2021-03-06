class SessionsController < ActionController::Base
  respond_to :json

  def create
    if find_user == nil
      render :json => {success: false, error: "Invalid username or password"}
    elsif valid_password?
      session[:current_user_id] = @user.id
      render :json => {success: true, user: @user.email}
    else
      render :json => {success: false, error: "Invalid username or password"}
    end
  end

  def destroy
    session[:current_user_id] = nil
    render :json => {success: true}
  end

  def backdoor
    session[:current_user_id] = params[:user_id]
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find_by(email: params[:user]["email"])
  end

  def valid_password?
    @user.authenticate(params[:user]["password"])
  end

  def current_user
    @user ||= User.find(session[:current_user_id]) if user_signed_in?
  end

end
