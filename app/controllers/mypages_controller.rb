class MypagesController < ApplicationController
  # GET /mypages
  # GET /mypages.json
  def index
    @mypages = Mypage.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mypages }
    end
  end

  # GET /mypages/1
  # GET /mypages/1.json
  def show
    @mypage = Mypage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mypage }
    end
  end

  # GET /mypages/new
  # GET /mypages/new.json
  def new
    @mypage = Mypage.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mypage }
    end
  end

  # GET /mypages/1/edit
  def edit
    @mypage = Mypage.find(params[:id])
  end

  # POST /mypages
  # POST /mypages.json
  def create
    @mypage = Mypage.new(params[:mypage])

    respond_to do |format|
      if @mypage.save
        format.html { redirect_to @mypage, notice: 'Mypage was successfully created.' }
        format.json { render json: @mypage, status: :created, location: @mypage }
      else
        format.html { render action: "new" }
        format.json { render json: @mypage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mypages/1
  # PUT /mypages/1.json
  def update
    @mypage = Mypage.find(params[:id])

    respond_to do |format|
      if @mypage.update_attributes(params[:mypage])
        format.html { redirect_to @mypage, notice: 'Mypage was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mypage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mypages/1
  # DELETE /mypages/1.json
  def destroy
    @mypage = Mypage.find(params[:id])
    @mypage.destroy

    respond_to do |format|
      format.html { redirect_to mypages_url }
      format.json { head :no_content }
    end
  end
end
