class CommentsController < ApplicationController
  def create
    comment = Comment.new(params[:comment])
    logger.debug("Commented_id #{params[:commented_id]}")
    logger.debug("Commented_type #{params[:commented_type]}")
    logger.debug("Page #{params[:page]}")
    @post = Issue.find(params[:commented_id])
    @category = params[:commented_type]
    @current_page = params[:page]
    ActiveRecord::Base.transaction do
      if comment.save
        comment.subscribe_to(@post, current_admin)
        flash[:notice] = I18n.t("successfully_created")
        @comment = Comment.new
        respond_to do |format|
          format.html { redirect_to issues_management_path(@post, :category => @category, :page => @current_page) }
          format.json { render :json => @post, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @post.comment.errors.full_messages.each do |msg|
           logger.warn("@post.errors: #{msg}")
        end
        respond_to do |format|
          format.html { redirect_to issues_management_path(@post, :category => @category, :page => @current_page) }
          format.json { render :json => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end
end
