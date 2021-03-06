class OkboardsController < OkController
  
  def initialize
    super
    @sns_lock = Mutex.new
  end

  before_filter :_before_, :except => ["mypage","yellowpage"]

  def _before_
    redirect_to root_path and return if params[:v].nil?
    logger.debug("v: #{params[:v]} c: #{params[:c]} d: #{params[:d]} s: #{params[:s]}")
    @board = Okboard.param_v(params[:v])
    redirect_to root_path and return if !@board.present?
    @@category = params[:c].present? ? Okboard.param_to_s(params[:c]) : nil
    @@board_id = params[:d].present? ? Okboard.param_to_i(params[:d]) : nil
    @@search_id = params[:s].present? ? Okboard.param_to_i(params[:s]) : nil
    logger.debug("@board: #{@board} category: #{@@category} board_id: #{@@board_id} search_id #{@@search_id}")
    @okpage = @board.to_sym
  end

  def mypage
    @okpage = :p_mypage
    if !current_user
      session["user_return_to"] = request.original_url
      redirect_to user_sign_in_path
    end
    @user = User.find(current_user)
    @job_post = Job.user_post(@user)
    @buy_and_sell_post = BuyAndSell.user_post(@user)
    @well_being_post = WellBeing.user_post(@user)
    respond_to do |format|
      format.html { render :template => "okboards/index" }
    end
  end

  def yellowpage
    @okpage = :p_yellowpage
    @business_categories = BusinessCategory.with_client
    @l_business_categories = @business_categories[0, Okvalue::YELLOW_PAGE_LEFT_MIN-1] || []
    @r_business_categories = @business_categories[Okvalue::YELLOW_PAGE_LEFT_MIN, @l_business_categories.length] || []
    logger.debug("@l_business_categories: #{@l_business_categories.length}")
    logger.debug("@r_business_categories: #{@r_business_categories.length}")
    respond_to do |format|
      format.html { render :template => "okboards/index" }
    end
  end

  def index
    logger.debug("v: #{@board}")
    model = MODELS[@okpage]
    raise "Bad Board Request" if model.nil?
    if @@search_id.present?
      @post_search = PostSearch.find(@@search_id)
    else
      @post_search = PostSearch.new(:okpage => @okpage)
      if @@category
        @post_search.category = @@category
        ActiveRecord::Base.transaction do
          if @post_search.save
              @post_search.set_user(current_user) if current_user
          end
        end
      end
    end
    # Find Search Condition
    if [:p_job,:p_buy_and_sell,:p_well_being,:p_estate,:p_business,:p_motor_vehicle,:p_accommodation].include?(@okpage)
      post_search = @post_search.dup
      post_search.image = true
      @board_image_lists = model.search(post_search, Okvalue::OKBOARD_IMAGE_FEED_LIMIT)
      ids = @board_image_lists.collect {|post| post.id }
      @board_lists = model.search_except(@post_search, ids, Okvalue::OKBOARD_LIMIT)
    else
      @board_lists = model.search(@post_search, Okvalue::OKBOARD_LIMIT)
    end
    @post = model.new
    @lastid = find_lastid(@board_lists, @board_image_lists)
    logger.debug("@board_lists: #{@board_lists.size}  @lastid: #{@lastid}")
    logger.debug("@board_image_lists: #{@board_image_lists.size}") if @board_image_lists
    logger.debug("SearchedBy #{@post_search}")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @post }
    end
  end

  def view
    @post = _select_post
    @post_search = PostSearch.new(:okpage => @okpage)
    if @post.nil? || @post.status != Okvalue::POST_STATUS_PUBLIC
      if @post.nil?
        model = MODELS[@okpage]
        @post = model.new
      end
      respond_to do |format|
        format.html { render :template => "okboards/view_deleted" }
        format.json { render :json => @post }
      end
    else
      @search_id = @@search_id if @@search_id.present?
      @post.viewed
      @comment = Comment.new
    end
  end

  def write
    if !current_user
      session["user_return_to"] = request.original_url
      redirect_to user_sign_in_path
    end
    @post = _write_post
  end

  #ajax
  def more
    @previd = params[:lastid]
    if @@search_id.present?
      @post_search = PostSearch.find(@@search_id)
    else
      @post_search = PostSearch.new(:okpage => @okpage)
    end
    logger.debug("lastid: #{@previd}")
    @board_lists = _more_post
    @lastid = find_lastid(@board_lists)
    @lastid ||= @previd
    logger.debug("@lastid: #{@lastid}")
  end
  
  #ajax
  def post_admin_notice
    list_size = params[:num].to_i
    model = MODELS[@okpage]
    @board_lists = model.priority_post
    @board_list_size = list_size + @board_lists.size
    logger.debug("notice: #{@board_lists} #{@board_list_size}")
  end

  # Ajax
  def likes
    model = MODELS[@okpage]
    @sns_lock.synchronize {
      ActiveRecord::Base.transaction do
        model.find(@@board_id).like
      end
    }
    @post = model.find(@@board_id)
  end

  # Ajax
  def dislikes
    model = MODELS[@okpage]
    @sns_lock.synchronize {
      ActiveRecord::Base.transaction do
        model.find(@@board_id).dislike
      end
    }
    @post = model.find(@@board_id)
  end

  # Ajax
  def abuses
    model = MODELS[@okpage]
    @sns_lock.synchronize {
      ActiveRecord::Base.transaction do
        model.find(@@board_id).report_abuse
      end
    }
    @post = model.find(@@board_id)
  end
  
  # Ajax
  def next_post
      @post_search = @@search_id.present? ?  PostSearch.find(@@search_id)  : PostSearch.new(:okpage => @okpage)
      @next_post = _model.search_after(@post_search, @@board_id, 1).first
      logger.debug("next_post #{@next_post}")
  end

  #Ajax
  def prev_post
      @post_search = @@search_id.present? ?  PostSearch.find(@@search_id)  : PostSearch.new(:okpage => @okpage)
      @prev_post = _model.search_before(@post_search, @@board_id, 1).first
      logger.debug("prev_post #{@prev_post}")    
  end

  private

  def _more_post
    _model.search_before(@post_search,@previd,Okvalue::OKBOARD_MORE_SIZE)
  end

  def _select_post
    return nil if !@@board_id.present?
    begin
      post = _model.find(@@board_id)
      post
    rescue
      nil
    end
  end

  def _write_post
    post = _model.new
    post.write_at = Common.current_time.to_i
    post.build_content
    post.valid_until = post_expiry
    @image = Image.new
    @image.write_at = post.write_at
    @attachment = Attachment.new
    @attachment.write_at = post.write_at
    post
  end

  def _model
    model = MODELS[@okpage]
    raise "Not implemented for #{@okpage}" if model.nil?
    logger.debug("model: #{model.name}")
    model
  end
end
