class PasswordsController < Devise::PasswordsController
  
  before_filter :okpage
  
  def okpage
    @okpage = :p_signin
  end
  
end