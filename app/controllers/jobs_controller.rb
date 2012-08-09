class JobsController < ApplicationController
  
  before_filter :filter
  
  def filter
    @okpage = :p_job
  end
  
  def create
    post = params[:job]
    logger.debug("post: #{post}")
    if post[:attachment]
      @attachment = Attachment.new(:avatar => post[:attachment][:avatar])
      logger.debug("avatar: #{@attachment}")
      post.delete :attachment
      logger.debug("post: #{post}")
    end
    @post = Job.new(post)
    logger.debug("post: #{@post}")
    @post.valid_until = post_expiry
    respond_to do |format|
      if @post.save
        @post.set_user(current_user)
        @attachment.attached_to_by(@post, current_user) if @attachment
        @board_lists = Job.latest
        @lastid = find_lastid(@board_lists)
        format.html { render :template => "okboards/index", notice: I18n.t('successfully_created') }
        format.json { render json: @post, status: :created }
      else
        flash[:warning] = I18n.t("failed_to_create")
        logger.debug("@post.errors: #{@post.errors}")
        format.html { render :template => "okboards/write" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end

