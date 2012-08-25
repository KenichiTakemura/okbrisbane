class MypagesController < ApplicationController
  # GET /mypages/1
  # GET /mypages/1.json
  def show
    @mypage = Mypage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @mypage }
    end
  end
end
