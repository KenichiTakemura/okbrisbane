class OkboardsController < OkController

  before_filter :_before_

  def _before_
    raise "Bad Request" if params[:v].nil?
    logger.debug("v #{params[:v]} c: #{params[:c]}")
    @board = Common.decrypt_data(params[:v])
    category = Common.decrypt_data(params[:c]) if !params[:c].nil?
    logger.debug("@board: #{@board} category: #{category}")
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
    when Style.page(:p_law)
    when Style.page(:p_tax)
    when Style.page(:p_yellowpage)
    else
    raise "Bad Board Request"
    end
    _lastid(@board_lists)
    logger.debug("@board_lists: #{@board_lists.size}  @lastid: #{@lastid}")
    logger.debug("@board_image_lists: #{@board_image_lists.size}") if @board_image_lists
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
  end
  
  def more
    sleep 2
    @previd = params[:lastid]
    logger.debug("lastid: #{@previd}")
    case @board
    when Style.page(:p_motor_vehicle)
      @board_lists = MotorVehicle.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
    when Style.page(:p_estate)
      @board_lists = Estate.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
    when Style.page(:p_business)
      @board_lists = Business.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
    when Style.page(:p_job)
      @board_lists = Job.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
    else
      raise "Not implemented"
    end
    _lastid(@board_lists)
    @lastid ||= @previd
    logger.debug("@lastid: #{@lastid}")
  end

  private
 
  # TODO lastedid should be replaced with last_updated_at
  def _lastid(board_list)
    if !board_list.nil? && !board_list.empty?
      @lastid = board_list.last.id 
    else
      @lastid = nil
    end
    logger.debug("@lastid: #{@lastid}")
  end
  
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
  
end
