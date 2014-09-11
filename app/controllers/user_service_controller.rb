class UserServiceController < ApplicationController

  def update
    if user_signed_in?
      current_user.update_attribute('service_list', params[:service_list])
      render :json => {success: true}
    else
      render :json => {success: false}
    end
  end

end