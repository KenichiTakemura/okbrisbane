class ConfirmationsController < Devise::ConfirmationsController
  
  before_filter :okpage
  
  def okpage
    @okpage = :p_home
  end
  
end