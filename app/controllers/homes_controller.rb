class HomesController < OkController
  
  def collectFeed(category)
    case category
    when :p_job
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT)
    when :p_buy_and_sell
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT)
    when :p_estate
      return TopFeedList.feed_without_image(category, TopFeedList::TOP_FEED_LIMIT), TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
    when :p_business
      return TopFeedList.feed_without_image(category, TopFeedList::TOP_FEED_LIMIT), TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
    when :p_motor_vehicle
      return TopFeedList.feed_without_image(category, TopFeedList::TOP_FEED_LIMIT), TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
    when :p_accommodation
      return TopFeedList.feed_without_image(category, TopFeedList::TOP_FEED_LIMIT), TopFeedList.feed_with_image(category, TopFeedList::IMAGE_FEED_LIMIT) 
    when :p_law
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT_LOWER)
    when :p_study
      return TopFeedList.feed_nomatter_image(category, TopFeedList::TOP_FEED_LIMIT_LOWER)
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
    @okpage = :p_home
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @estate_lists }
      format.json { render :json => @estate_image_lists }
    end
  end
  
  def current_weather
    @country = params[:c]
    @weather = Weather.weather_for(Common.today, @country)
    @dateOn = Common.today
  end

  def collect_weather
    require 'net/ftp'
    tries = 0
    begin
      tries += 1
      logger.info("Accessing to #{Okvalue::WEATHER_AUS}")
      Net::FTP.open(Okvalue::WEATHER_AUS) do |ftp|
        ftp.passive = true
        ftp.login
        ftp.getbinaryfile("anon/gen/fwo/IDA00100.dat")
        ftp.close
        logger.debug(ftp.read)
      end
      logger.info("Returned.")
    rescue Exception => e
      logger.error(e.message)
      if (tries < Okvalue::WEATHER_RETRY)
        sleep(2**tries)
        retry
      end
    end
  end

  private

end
