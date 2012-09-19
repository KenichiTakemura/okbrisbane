class WellBeingsController < PostsController
  
  before_filter :filter
  
  def filter
    @okpage = :p_well_being
  end
  
  def create
    logger.debug("create well_being post by #{current_user}")
    create_post(WellBeing, :well_being)
  end
    
end