class CommentsController < OkController
  
  def create
    comment = Comment.new(params[:comment])
    logger.debug("Commented_id #{params[:commented_id]}")
    logger.debug("Commented_type #{params[:commented_type]}")
    @okpage = params[:commented_type].to_sym
    model = MODELS[@okpage]
    @post = model.find(params[:commented_id])

    ActiveRecord::Base.transaction do
      if comment.save
        comment.subscribe_to(@post, current_user)
        @comment = Comment.new
        respond_to do |format|
          format.html { redirect_to "#{Okboard.okboard_link_with_id(@okpage, @post.id)}" }
          format.json { render :json => @post, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @post.errors.full_messages.each do |msg|
           logger.warn("@post.errors: #{msg}")
        end
        respond_to do |format|
          format.html { render :template => "okboards/view" }
          format.json { render :json => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
  
  # Ajax
  def likes
    ActiveRecord::Base.transaction do
      Comment.find(params[:id]).like
    end
    @comment = Comment.find(params[:id])
  end
  
  def dislikes
    ActiveRecord::Base.transaction do
      Comment.find(params[:id]).dislike
    end
    @comment = Comment.find(params[:id])
  end
  
  def abuses
    ActiveRecord::Base.transaction do
      Comment.find(params[:id]).report_abuse
    end
    @comment = Comment.find(params[:id])
  end

end
