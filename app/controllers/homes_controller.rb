class HomesController < OkController
  def collectFeed(category)
    case category
    when Okvalue::JOB
      return TopFeedList.job_feed
    when Okvalue::BUY_AND_SELL
      return TopFeedList.buy_and_sell_feed
    when Okvalue::ESTATE
      return _makeImageList(TopFeedList.estate_feed)
    when Okvalue::BUSINESS
      return _makeImageList(TopFeedList.business_feed)
    when Okvalue::MOTOR_VEHICLE
      return _makeImageList(TopFeedList.motor_vehicle_feed)
    when Okvalue::ACCOMMODATION
      return _makeImageList(TopFeedList.accommodation_feed)
    when Okvalue::LAW
      return TopFeedList.legal_service_feed_with_limit(5)
    when Okvalue::STUDY
      return TopFeedList.study_feed_with_limit(5)
    else
    raise "Bad Category"
    end
  end

  def _makeImageList(feed_list)
    image_list = Array.new
    feed_list.each_with_index do |feed, i|
      if !feed.feeded_to.image.empty?
        image_list.push(feed)
        feed_list.slice!(i)
        break if(image_list.size >= TopFeedList::IMAGE_FEED_LIMIT)
      end
    end
    return feed_list, image_list
  end

  def index
    @job_feed_lists = collectFeed(Okvalue::JOB)
    @buy_and_sell_feed_lists = collectFeed(Okvalue::BUY_AND_SELL)
    @estate_lists,@estate_image_lists  = collectFeed(Okvalue::ESTATE)
    @business_lists,@business_image_lists = collectFeed(Okvalue::BUSINESS)
    @motor_vehicle_lists,@motor_vehicle_image_lists = collectFeed(Okvalue::MOTOR_VEHICLE)
    @accommodation_lists,@accommodation_image_lists = collectFeed(Okvalue::ACCOMMODATION)
    @legal_service_lists = collectFeed(Okvalue::LAW)
    @study_lists = collectFeed(Okvalue::STUDY)
    @okpage = Style::PAGES[:p_home]
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  private

end
