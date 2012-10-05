class BannersController < OkController
  
  def show_banner
    @div_id = params[:div]
    @banner = Banner.find(params[:b])
  end

end
