class OkboardsController < OkController

  before_filter :_before_

  $okboard_map = Hash.new
  def _before_
    raise "Bad Request" if params[:v].nil?
    v = params[:v]
    logger.debug("$okboard_map: #{$okboard_map}")
    if !$okboard_map[v.to_sym].nil?
      @board = $okboard_map[v.to_sym]
      logger.debug("Found: #{@board} v: #{v}")
    else
      Style::PAGES.each do |key, value|
        logger.debug("value: #{value.crypt("okboard")} v: #{v}")
        if value.crypt("okboard").eql? v
          @board = value
          $okboard_map[v.to_sym] = value
          logger.debug("Added: #{@board} v: #{v}")
        break
        end
      end
    end
    @okpage = @board.to_sym
  end

  def index
    logger.debug("v: #{@board}")
    @post_search = PostSearch.new
    case @board
    when Style::PAGES[:p_job]
    when Style::PAGES[:p_buy_and_sell]
    when Style::PAGES[:p_wellbeing]
    when Style::PAGES[:p_study]
    when Style::PAGES[:p_immig]
    when Style::PAGES[:p_estate]
      @board_lists,@board_image_lists  = _makePostImageList(Estate.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = Estate.new
    when Style::PAGES[:p_motor_vehicle]
      @board_lists,@board_image_lists  = _makePostImageList(MotorVehicle.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = MotorVehicle.new
    when Style::PAGES[:p_business]
      @board_lists,@board_image_lists  = _makePostImageList(Business.latest, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      @post = Business.new  
    when Style::PAGES[:p_law]
    when Style::PAGES[:p_tax]
    when Style::PAGES[:p_yellowpage]
    else
    raise "Bad Board Request"
    end
    _lastid(@board_lists)
    logger.debug("@board_lists: #{@board_lists.size} @board_image_lists: #{@board_image_lists.size} @lastid: #{@lastid}")
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
    when Style::PAGES[:p_motor_vehicle]
      @board_lists = MotorVehicle.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
    when Style::PAGES[:p_estate]
      @board_lists = MotorVehicle.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
    when Style::PAGES[:p_business]
      @board_lists = Business.where("id < ?", @previd).limit(Okvalue::OKBOARD_MORE_SIZE)
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
  
  def _makePostImageList(posts, limit)
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
