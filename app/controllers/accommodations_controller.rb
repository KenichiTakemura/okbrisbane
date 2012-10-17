class AccommodationsController < PostsController
  
  before_filter :filter
  
  def filter
    @okpage = :p_accommodation
  end
  
  def create
    logger.debug("create Accommodation post by #{current_user}")
    create_post(Accommodation, :accommodation)
  end
    
end