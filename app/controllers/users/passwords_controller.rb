class Users::PasswordsController < Devise::PasswordsController
  
  before_filter :okpage
  
  def okpage
    @okpage = :p_signin
  end
  
  def after_sending_reset_password_instructions_path_for(resource_name)
     logger.debug("after_sending_reset_password_instructions_path_for")
     user_sending_reset_password_instructions_path(:email => resource.email)
  end
  
  def after_sign_in_path_for(resource)
    logger.debug("after_sign_in_path_for")
    user_after_reset_passwod_path
  end
  
end