class CommentsController < OkController
  
  before_filter :authenticate_user!, :only => [:create, :reply]
  
  def initialize
    super
    @lock = Mutex.new
  end

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
  
  # Redirect to sign in
  def new
    logger.debug("Comment_signin : category: #{params[:category]} id: #{params[:id]}")
    @okpage = params[:category].to_sym
    model = MODELS[@okpage]
    @post = model.find(params[:id])
    if !current_user
      session["user_return_to"] = Okboard.okboard_link_with_id_write_comment(@okpage, @post.id)
      redirect_to user_sign_in_path
    else
    end      
  end

  # Redirect to sign in
  def reply
    @comment = Comment.find(params[:id])
  end

  # Ajax
  def likes
    @lock.synchronize {
      ActiveRecord::Base.transaction do
        Comment.find(params[:id]).like
      end
    }
    @comment = Comment.find(params[:id])
  end

  def dislikes
    @lock.synchronize {
      ActiveRecord::Base.transaction do
        Comment.find(params[:id]).dislike
      end
    }
    @comment = Comment.find(params[:id])
  end

  def abuses
    @lock.synchronize {
      ActiveRecord::Base.transaction do
        Comment.find(params[:id]).report_abuse
      end
    }
    @comment = Comment.find(params[:id])
  end

end
