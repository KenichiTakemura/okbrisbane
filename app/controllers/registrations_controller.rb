class RegistrationsController < Devise::RegistrationsController
  
  def new
    if session[:agreed]
      super
    else
      redirect_to member_managements_sign_up_path
    end
  end
end