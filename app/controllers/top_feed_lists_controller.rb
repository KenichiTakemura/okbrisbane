class TopFeedListsController < ApplicationController
  # GET /top_feed_lists
  # GET /top_feed_lists.json
  def index
    @top_feed_lists = TopFeedList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @top_feed_lists }
    end
  end

  # GET /top_feed_lists/1
  # GET /top_feed_lists/1.json
  def show
    @top_feed_list = TopFeedList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @top_feed_list }
    end
  end

  # GET /top_feed_lists/new
  # GET /top_feed_lists/new.json
  def new
    @top_feed_list = TopFeedList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @top_feed_list }
    end
  end

  # GET /top_feed_lists/1/edit
  def edit
    @top_feed_list = TopFeedList.find(params[:id])
  end

  # POST /top_feed_lists
  # POST /top_feed_lists.json
  def create
    @top_feed_list = TopFeedList.new(params[:top_feed_list])

    respond_to do |format|
      if @top_feed_list.save
        format.html { redirect_to @top_feed_list, notice: 'Top feed list was successfully created.' }
        format.json { render json: @top_feed_list, status: :created, location: @top_feed_list }
      else
        format.html { render action: "new" }
        format.json { render json: @top_feed_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /top_feed_lists/1
  # PUT /top_feed_lists/1.json
  def update
    @top_feed_list = TopFeedList.find(params[:id])

    respond_to do |format|
      if @top_feed_list.update_attributes(params[:top_feed_list])
        format.html { redirect_to @top_feed_list, notice: 'Top feed list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @top_feed_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /top_feed_lists/1
  # DELETE /top_feed_lists/1.json
  def destroy
    @top_feed_list = TopFeedList.find(params[:id])
    @top_feed_list.destroy

    respond_to do |format|
      format.html { redirect_to top_feed_lists_url }
      format.json { head :no_content }
    end
  end
end
