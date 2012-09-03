class OkboardsController < OkController

  before_filter :_before_
  
  def _before_
    raise "Bad Request" if params[:v].nil?
    logger.debug("v #{params[:v]} c: #{params[:c]} d: #{params[:d]}")
    @board = Common.decrypt_data(params[:v])
    @@category = nil
    @@board_id = nil
    @@category = Common.decrypt_data(params[:c]) if !params[:c].nil?
    @@board_id = Common.decrypt_data(params[:d]).to_i if !params[:d].nil?
    logger.debug("@board: #{@board} category: #{@@category} board_id: #{@@board_id}")
    @okpage = @board.to_sym
    if @okpage.eql?(:p_mypage)
      if !current_user
        session["user_return_to"] = request.original_url
        redirect_to user_sign_in_path
      end
    end
  end

  def index
    logger.debug("v: #{@board}")
    model = MODELS[@okpage]
    raise "Bad Board Request" if model.nil?
    if @@category
      @board_lists,@board_image_lists  = _make_post_list_with_image(model.category_latest(@@category).latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
    else
      if @okpage.eql?(:p_mypage)
         @user = User.find(current_user)
      elsif @okpage.eql?(:p_yellowpage)
      else
        @board_lists,@board_image_lists  = _make_post_list_with_image(model.latest(@@category).latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
        @post = model.new
        @lastid = find_lastid(@board_lists)
        logger.debug("@board_lists: #{@board_lists.size}  @lastid: #{@lastid}")
        logger.debug("@board_image_lists: #{@board_image_lists.size}") if @board_image_lists
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @jobs }
    end
  end

  def view
    raise if @@board_id.nil?
    @post = _select_post
    @post.viewed
    @comment = Comment.new
  end

  def write
    if !current_user
      session["user_return_to"] = request.original_url
      redirect_to user_sign_in_path
    end
    @post = _write_post
  end

  def more
    @previd = params[:lastid]
    logger.debug("lastid: #{@previd}")
    @board_lists = _more_post
    @lastid = find_lastid(@board_lists)
    @lastid ||= @previd
    logger.debug("@lastid: #{@lastid}")
  end

  #ajax
  def get_image
    timestamp = params[:timestamp]
    images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, timestamp)
    image_ids = images.collect{|i| i.id}
    thumbnails = images.collect{|i| i.thumb_image}
    somethingies = images.collect{|i| i.something}
    render :json => {:result => 0, :images => image_ids, :thumbnails => thumbnails, :somethingies => somethingies }
  end

  # ajax
  def upload_image
    logger.debug("upload_image")
    file = params[:file]
    timestamp = params[:timestamp]
    image = Image.new(:avatar => file)
    if image.thumbnailable?
      image.write_at = timestamp;
      image.something = params[:something]
      image.attached_by(current_user)
      logger.debug("image saved. #{image}")
      images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, timestamp)
      image_ids = images.collect{|i| i.id}
      thumbnails = images.collect{|i| i.thumb_image}
      somethingies = images.collect{|i| i.something}
      render :json => {:result => 0, :images => image_ids, :thumbnails => thumbnails, :somethingies => somethingies }
    else
      logger.debug("not thumbnailable? #{image}")
      render :json => {:result => 1}
    end
  rescue
    render :json => {:result => 1}
    end

  #ajax
  def delete_image
    logger.debug("delete_image")
    image = Image.find(params[:id])
    @timestamp = params[:t]
    image.destroy
    @images = Image.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, @timestamp)
  end

  #ajax
  def get_attachment
    timestamp = params[:timestamp]
    json_attachment(timestamp)
  end

  #ajax
  def upload_attachment
    logger.debug("upload_attachment")
    file = params[:file]
    timestamp = params[:timestamp]
    logger.debug("file: #{file}")
    logger.debug("timestamp: #{timestamp}")
    attach = Attachment.new(:avatar => file)
    logger.debug("attachment: #{attach}")
    attach.write_at = timestamp;
    attach.attached_by(current_user)
    logger.debug("attachment saved. #{attach}")
    json_attachment(timestamp)
  #rescue
  #  render :json => {:result => 1}
  end

  #ajax
  def delete_attachment
    logger.debug("delete_attachment")
    attachment = Attachment.find(params[:id])
    @timestamp = params[:t]
    attachment.destroy
    @attachments = Attachment.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, @timestamp)
  end

  private

  def json_attachment(timestamp)
    attachments = Attachment.where("attached_by_id = ? AND attached_id is NULL AND write_at = ?", current_user, timestamp)
    attachment_ids = attachments.collect{|i| i.id}
    attachment_files = attachments.collect{|i| i.avatar_file_name}
    render :json => {:result => 0, :attachments => attachment_ids, :filenames => attachment_files }
  end

  def _make_post_list_with_image(posts, limit)
    image_list = Array.new
    post_list = Array.new
    posts.each_with_index do |post, i|
      if(image_list.size < limit)
        if !post.image.empty?
        image_list.push(post)
        else
        post_list.push(post)
        end
      else
      post_list.push(post)
      end
    end
    return post_list, image_list
  end

  def _more_post
    _model.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
  end

  def _select_post
    post = _model.find(@@board_id)
    logger.debug("post: #{post}")
    post
  end

  def _write_post
    post = _model.new
    post.write_at = Time.now.to_i
    post.build_content
    post.valid_until = post_expiry
    post
  end

  def _model
    model = MODELS[@okpage]
    raise "Not implemented for #{@okpage}" if model.nil?
    logger.debug("model: #{model.name}")
    model
  end
end
