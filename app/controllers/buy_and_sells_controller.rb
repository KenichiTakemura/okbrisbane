class BuyAndSellsController < ApplicationController
  # GET /buy_and_sells
  # GET /buy_and_sells.json
  def index
    @buy_and_sells = BuyAndSell.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @buy_and_sells }
    end
  end

  # GET /buy_and_sells/1
  # GET /buy_and_sells/1.json
  def show
    @buy_and_sell = BuyAndSell.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @buy_and_sell }
    end
  end

  # GET /buy_and_sells/new
  # GET /buy_and_sells/new.json
  def new
    @buy_and_sell = BuyAndSell.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @buy_and_sell }
    end
  end

  # GET /buy_and_sells/1/edit
  def edit
    @buy_and_sell = BuyAndSell.find(params[:id])
  end

  # POST /buy_and_sells
  # POST /buy_and_sells.json
  def create
    @buy_and_sell = BuyAndSell.new(params[:buy_and_sell])

    respond_to do |format|
      if @buy_and_sell.save
        format.html { redirect_to @buy_and_sell, notice: 'Buy and sell was successfully created.' }
        format.json { render json: @buy_and_sell, status: :created, location: @buy_and_sell }
      else
        format.html { render action: "new" }
        format.json { render json: @buy_and_sell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /buy_and_sells/1
  # PUT /buy_and_sells/1.json
  def update
    @buy_and_sell = BuyAndSell.find(params[:id])

    respond_to do |format|
      if @buy_and_sell.update_attributes(params[:buy_and_sell])
        format.html { redirect_to @buy_and_sell, notice: 'Buy and sell was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @buy_and_sell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buy_and_sells/1
  # DELETE /buy_and_sells/1.json
  def destroy
    @buy_and_sell = BuyAndSell.find(params[:id])
    @buy_and_sell.destroy

    respond_to do |format|
      format.html { redirect_to buy_and_sells_url }
      format.json { head :no_content }
    end
  end
end
