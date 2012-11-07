class RegistrationsController < Devise::RegistrationsController
  
  before_filter :okpage
  
  def okpage
    @okpage = :p_signup
  end
  
  def new
    if session[:agreed]
      super
    else
      redirect_to member_managements_sign_up_path
    end
  end
  
  def create
    resource_params[:agreed_on] = Common.current_time
    resource_params[:provider] = User::PROVIDERS[:okbrisbane]
    # This is dummy
    resource_params[:uid] = Common.uniqe_token
    super
  end
  
  # If the account that is registered is confirmable and not active yet, you have to override after_inactive_sign_up_path_for method.
  def after_inactive_sign_up_path_for(resource)
    logger.debug("after_inactive_sign_up_path_for")
    user_inactive_signup_path(:email => resource.email)
  end
   
end