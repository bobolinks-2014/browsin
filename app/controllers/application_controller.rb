class ApplicationController < ActionController::Base
  

  protected
  
  def user_signed_in?
    session[:current_user_id] != nil
  end
  
  def current_user
    @user ||= User.find(session[:current_user_id]) if user_signed_in?
  end

  helper_method :user_signed_in?
  helper_method :current_user
end
