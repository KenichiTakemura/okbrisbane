class Users::ConfirmationsController < Devise::ConfirmationsController

  before_filter :okpage
  
  def okpage
    @okpage = :p_signin
  end

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    logger.debug("after_resending_confirmation_instructions_path_for")
    user_after_resending_confirmation_instructions_path
  end

  # The path used after confirmation.
  def after_confirmation_path_for(resource_name, resource)
    logger.debug("after_confirmation_path_for")
    user_after_confirmation_path
  end

end