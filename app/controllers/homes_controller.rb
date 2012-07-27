class HomesController < ApplicationController
  
  
  
  # GET /homes
  # GET /homes.json
  def index
    @job_feed_lists = TopFeedList.job_feed
    @buy_and_sell_feed_lists = TopFeedList.buy_and_sell_feed
    @estate_lists = TopFeedList.estate_feed
    @estate_image_lists = Array.new
    @business_image_lists = Array.new
    @motor_vehicle_image_lists = Array.new
    @accommodation_image_lists = Array.new
    @estate_lists.each_with_index do |feed, i|
      if !feed.feeded_to.image.empty?
        @estate_image_lists.push(feed)
        @estate_lists.slice!(i)
      end
    end
    logger.debug("@estate_lists.size: #{@estate_lists.size}")
    logger.debug("@estate_image_lists.size: #{@estate_image_lists.size}")
    @business_lists = TopFeedList.business_feed
    @motor_vehicle_lists = TopFeedList.motor_vehicle_feed
    @accommodation_lists = TopFeedList.accommodation_feed_with_limit(5)
    @legal_service_lists = TopFeedList.legal_service_feed_with_limit(5)
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
end
