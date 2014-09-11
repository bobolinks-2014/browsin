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

  def placeholder_text
    [ "I want to watch a Robin Williams comedy", 
      "I have 60 minutes for comedy with John Oliver", 
      "I'm in the mood for a rom-com",
      "I want to watch Heisenberg in Breaking Bad",
      "Do you have any movies with Julia Roberts?"
    ].sample
  end

  helper_method :placeholder_text
  helper_method :user_signed_in?
  helper_method :current_user
end
