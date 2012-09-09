class ConfirmationsController < Devise::ConfirmationsController

  before_filter :okpage
  
  def okpage
    @okpage = :p_signup
  end

  def after_confirmation_path_for(resource_name, resource)
    logger.debug("after_confirmation_path_for")
    user_after_confirmation_path << "?k=#{Okvalue::ACCESS_KEY}"
  end
  
end