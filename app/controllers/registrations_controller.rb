class Users < Devise::RegistrationsController
  # POST /resource/sign_up
  def create
    puts "WER MADE ITE"
    build_resource
  
    if resource.save
    set_flash_message :notice, :signed_up
  
    #sign_in_and_redirect(resource_name, resource)\
    #this commented line is responsible for sign in and redirection
    #change to something you want..
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end
end
