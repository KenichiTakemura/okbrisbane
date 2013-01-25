class Users::SessionsController < Devise::SessionsController
  
  before_filter :okpage
  
  def okpage
    @okpage = :p_signin
  end
  
  def self.force_sign_out(resource)
    sign_out(resource)
  end
  
end