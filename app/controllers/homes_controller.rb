class HomesController < OkController
  
  def collectFeed(category)
    case category
    when :p_job
      return TopFeedList.job_feed
    when :p_buy_and_sell
      return TopFeedList.buy_and_sell_feed
    when :p_estate
      return _makeImageList(TopFeedList.estate_feed, TopFeedList::IMAGE_FEED_LIMIT)
    when :p_business
      return _makeImageList(TopFeedList.business_feed, TopFeedList::IMAGE_FEED_LIMIT)
    when :p_motor_vehicle
      return _makeImageList(TopFeedList.motor_vehicle_feed, TopFeedList::IMAGE_FEED_LIMIT)
    when :p_accommodation
      return _makeImageList(TopFeedList.accommodation_feed, TopFeedList::IMAGE_FEED_LIMIT)
    when :p_law
      return TopFeedList.legal_service_feed_with_limit(5)
    when :p_study
      return TopFeedList.study_feed_with_limit(5)
    else
    raise "Bad Category"
    end
  end

  def index
    @job_feed_lists = collectFeed(:p_job)
    @buy_and_sell_feed_lists = collectFeed(:p_buy_and_sell)
    @estate_lists,@estate_image_lists  = collectFeed(:p_estate)
    @business_lists,@business_image_lists = collectFeed(:p_business)
    @motor_vehicle_lists,@motor_vehicle_image_lists = collectFeed(:p_motor_vehicle)
    @accommodation_lists,@accommodation_image_lists = collectFeed(:p_accommodation)
    @legal_service_lists = collectFeed(:p_law)
    @study_lists = collectFeed(:p_study)
    @okpage = Style::PAGES[:p_home]
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  private

end
