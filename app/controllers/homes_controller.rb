class HomesController < ApplicationController
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

  # GET /homes
  # GET /homes.json
  def index
    @job_feed_lists = collectFeed(Okvalue::JOB)
    @buy_and_sell_feed_lists = collectFeed(Okvalue::BUY_AND_SELL)
    @estate_lists,@estate_image_lists  = collectFeed(Okvalue::ESTATE)
    @business_lists,@business_image_lists = collectFeed(Okvalue::BUSINESS)
    @motor_vehicle_lists,@motor_vehicle_image_lists = collectFeed(Okvalue::MOTOR_VEHICLE)
    @accommodation_lists,@accommodation_image_lists = collectFeed(Okvalue::ACCOMMODATION)
    @legal_service_lists = collectFeed(Okvalue::LAW)
    @study_lists = collectFeed(Okvalue::STUDY)
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
    @home = Home.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @home }
    end
  end

  # GET /homes/new
  # GET /homes/new.json
  def new
    @home = Home.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @home }
    end
  end

  # GET /homes/1/edit
  def edit
    @home = Home.find(params[:id])
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(params[:home])

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render json: @home, status: :created, location: @home }
      else
        format.html { render action: "new" }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /homes/1
  # PUT /homes/1.json
  def update
    @home = Home.find(params[:id])

    respond_to do |format|
      if @home.update_attributes(params[:home])
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home = Home.find(params[:id])
    @home.destroy

    respond_to do |format|
      format.html { redirect_to homes_url }
      format.json { head :no_content }
    end
  end

  private

end
