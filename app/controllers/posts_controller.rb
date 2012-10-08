class PostsController < OkController

  before_filter :filter
  before_filter :authenticate_user!, :only => [:create_post]

  def filter
    
  end

  def create_post(_model, _param)
    @post = _model.new(params[_param])
    @post.valid_until = post_expiry
    logger.debug("post: #{@post}")
    # Check if attached from MSIE
    if params[:attachment]
      file_attached = params[:attachment]
      attached_file = Attachment.new(:avatar => file_attached)
    end
    if params[:image]
      image_attached = params[:image]
      something = params[:something]
      attached_image = Image.new(:avatar => image_attached, :something => something)
    end
    if @post.respond_to? :requested_by
      @post.requested_by = request.env['HTTP_USER_AGENT']
    end
    ActiveRecord::Base.transaction do
      if @post.save
        @post.set_user(current_user)
        if !params[:image]
          get_image(@post.write_at).each do |image|
            image.attached_to_by(@post, current_user)
          end
        else
          attached_image.attached_to_by(@post, current_user)
        end
        if !params[:attachment]
          get_attachment(@post.write_at).each do |attachment|
            attachment.attached_to_by(@post, current_user)
          end
        else
          attached_file.attached_to_by(@post, current_user)
        end
        @board_lists = Job.latest
        @lastid = find_lastid(@board_lists)
        flash[:notice] = I18n.t("successfully_created")
        respond_to do |format|
          format.html { redirect_to "#{Okboard.okboard_link(@okpage)}" }
          format.json { render :json => @post, :status => :created }
        end
      else
        flash[:warning] = I18n.t("failed_to_create")
        @post.errors.full_messages.each do |msg|
          logger.warn("@post.errors: #{msg}")
        end
        @post.build_content if @post.content.nil?
        respond_to do |format|
          format.html { render :template => "okboards/write" }
          format.json { render :json => @post.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  protected

  def get_image(timestamp)
    Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, timestamp)
  end

  def get_attachment(timestamp)
    Attachment.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, timestamp)
  end

end