class JobsController < PostsController
  
  before_filter :filter
  
  def filter
    @okpage = :p_law
  end
  
  def create
    logger.debug("create job post by #{current_user}")
    create_post(MODELS[@okpage], :law)
  end
    
end