class Users::SessionsController < Devise::SessionsController
  
  before_filter :okpage
  
  def okpage
    @okpage = :p_signin
  end
  
end