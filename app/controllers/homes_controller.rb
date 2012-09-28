class HomesController < OkController
  
  def collectFeed(category)
    case category
    when :p_job
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT)
    when :p_buy_and_sell
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT)
    when :p_estate
      image_list = TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
      list = TopFeedList.feed_nomatter_image_except(category, collect_image_id(image_list), TopFeedList::TOP_FEED_LIMIT)
      return list,image_list
    when :p_business
      image_list = TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
      list = TopFeedList.feed_nomatter_image_except(category, collect_image_id(image_list), TopFeedList::TOP_FEED_LIMIT)
      return list,image_list
    when :p_motor_vehicle
      image_list = TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
      list = TopFeedList.feed_nomatter_image_except(category, collect_image_id(image_list), TopFeedList::TOP_FEED_LIMIT)
      return list,image_list
    when :p_accommodation
      image_list = TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
      list = TopFeedList.feed_nomatter_image_except(category, collect_image_id(image_list), TopFeedList::TOP_FEED_LIMIT)
      return list,image_list
    when :p_law
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT_LOWER)
    when :p_study
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT_LOWER)
    else
    raise "Bad Category"
    end
  end
  
  def pick_feed
    @job_feed_lists = collectFeed(:p_job)
    @buy_and_sell_feed_lists = collectFeed(:p_buy_and_sell)
    @estate_lists,@estate_image_lists  = collectFeed(:p_estate)
    @business_lists,@business_image_lists = collectFeed(:p_business)
    @motor_vehicle_lists,@motor_vehicle_image_lists = collectFeed(:p_motor_vehicle)
    @accommodation_lists,@accommodation_image_lists = collectFeed(:p_accommodation)
    @legal_service_lists = collectFeed(:p_law)
    @study_lists = collectFeed(:p_study)
  end

  def index
    if !top_page_ajaxable?
      pick_feed
    else
    end
    @okpage = :p_home
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # Ajax
  def top_feed
    @okpage = :p_home
    @category = params[:c].to_sym
    if [:p_job,:p_buy_and_sell,:p_law,:p_study].include? @category
      @list = collectFeed(@category)
    else
      @list,@image_list = collectFeed(@category)
    end
    logger.debug("top_feed: #{@category} #{@list} #{@image_list}")
  end
  
  def current_weather
    @country = params[:c]
    @weather = Weather.weather_for(Common.today, @country)
    @dateOn = @weather.first.forecast_for if @weather.present?
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
