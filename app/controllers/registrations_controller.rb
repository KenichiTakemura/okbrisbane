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
end