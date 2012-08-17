class JobsController < PostsController
  
  before_filter :filter
  
  def filter
    @okpage = :p_job
  end
  
  def create
    logger.debug("create job post by #{current_user}")
    create_post(Job, :job)
  end
    
end