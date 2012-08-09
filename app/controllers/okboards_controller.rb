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
  end

  def index
    logger.debug("v: #{@board}")
    @post_search = PostSearch.new
    case @board
    when Style.page(:p_job)
      @board_lists = Job.latest
      @post = Job.new
    when Style.page(:p_buy_and_sell)
      @board_lists = BuyAndSell.latest
      @post = BuyAndSell.new
    when Style.page(:p_wellbeing)
    when Style.page(:p_study)
    when Style.page(:p_immig)
    when Style.page(:p_estate)
      @board_lists,@board_image_lists  = _make_post_list_with_image(Estate.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = Estate.new
    when Style.page(:p_motor_vehicle)
      @board_lists,@board_image_lists  = _make_post_list_with_image(MotorVehicle.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = MotorVehicle.new
    when Style.page(:p_business)
      @board_lists,@board_image_lists  = _make_post_list_with_image(Business.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = Business.new  
    when Style.page(:p_accommodation)
      @board_lists,@board_image_lists  = _make_post_list_with_image(Accommodation.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = Accommodation.new  
    when Style.page(:p_law)
    when Style.page(:p_tax)
    when Style.page(:p_yellowpage)
    else
    raise "Bad Board Request"
    end
    @lastid = find_lastid(@board_lists)
    logger.debug("@board_lists: #{@board_lists.size}  @lastid: #{@lastid}")
    logger.debug("@board_image_lists: #{@board_image_lists.size}") if @board_image_lists
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end
  
  def view
    raise if @@board_id.nil?
    @post = _select_post
  end
  
  def write
    if !current_user
      session["user_return_to"] = request.original_url
      redirect_to user_sign_in_path 
    end
    @post = _write_post
    @post.attachment.build
  end
  
  def more
    @previd = params[:lastid]
    logger.debug("lastid: #{@previd}")
    @board_lists = _more_post
    @lastid = find_lastid(@board_lists)
    @lastid ||= @previd
    logger.debug("@lastid: #{@lastid}")
  end

  private
  
  def _make_post_list_with_image(posts, limit)
    image_list = Array.new
    posts.each_with_index do |post, i|
      if !post.image.empty?
        image_list.push(post)
        posts.slice!(i)
        break if(image_list.size >= limit)
      end
    end
    return posts, image_list
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
    post.build_content
    post
  end
    
  def _model
    model = MODELS[@okpage]
    raise "Not implemented for #{@okpage}" if model.nil?
    logger.debug("model: #{model.name}")
    model
  end
end
