class HomesController < OkController
  
  def collectFeed(category)
    limit = TopFeedList::TOP_FEED_LIMIT_CATE[category].presence || TopFeedList::TOP_FEED_LIMIT
    if Style.text_feed?(category)
      return TopFeedList.feed_nomatter_image(category, limit)
    elsif Style.image_feed?(category)
      image_list = TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
      list = TopFeedList.feed_nomatter_image_except(category, collect_image_id(image_list), limit)
      return list,image_list
    else
      raise "Bad Category"
    end
  end
  
  def pick_feed
    Style::FEED_WITHOUT_IMAGE.each do |category|
      @feed_lists[category] = collectFeed(category)
    end
    Style::FEED_WITH_IMAGE.each do |category|
      @feed_lists[category],@image_feed_lists[category] = collectFeed(category)
    end
  end

  def index
    if !top_page_ajaxable?
      @feed_lists = Hash.new
      @image_feed_lists = Hash.new
      pick_feed
    else
      @feed_lists = Hash.new
      @image_feed_lists = Hash.new
      Style::FEED_WITHOUT_IMAGE.each do |category|
        if Okvalue::FEED_SHOW_SIZE[category] < 1
          @feed_lists[category] = collectFeed(category)
        end
      end
      Style::FEED_WITH_IMAGE.each do |category|
        if Okvalue::FEED_SHOW_SIZE[category] < 1
          @feed_lists[category],@image_feed_lists[category] = collectFeed(category)
        end
      end
    end
    @okpage = :p_home
    @user = User.new if !current_user
    @weather_au = Weather.weather_for_location(Common.today, Okvalue::AU, :Brisbane).first
    @weather_kr = Weather.weather_for_location(Common.today, Okvalue::KR, :seo).first
    @rates = Rate.rate_for()
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # Ajax
  def top_feed
    @okpage = :p_home
    @category = params[:c].to_sym
    if Style.text_feed?(@category)
      @list = collectFeed(@category)
    else
      @list,@image_list = collectFeed(@category)
    end
    logger.debug("top_feed: #{@category} #{@list} #{@image_list}")
  end
  
  def current_weather
    @country = params[:c]
    weather = Weather.weather_for(Common.today, @country)
    logger.debug("weather: #{weather.size}")
    @weather_map = Common.new_orderd_hash
    weather.each do |w|
      logger.debug("weather: #{w.location}")
      @weather_map[w.location.to_sym] = w
    end
    logger.debug("@weather_map: #{@weather_map}")
    @dateOn = weather.first.forecast_for if weather.present?
  end

  def current_rate
    @rates = Rate.rate_for()
    @dateOn = Common.date_format_ymdhm(@rates.first.issuedOn) if @rates.present?
  end
  
  def admin_notice
    @admin_notices = AdminNotice.notice_history
  end

  private

  def collect_image_id(image_list)
    ids = image_list.collect {|feed| feed.id }
  end

end
