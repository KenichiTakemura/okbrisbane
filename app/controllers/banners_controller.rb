class BannersController < OkController
  
  def show_single_banner
    @div_id = params[:div]
    @banner = Banner.find(params[:b])
  end

  def show_multi_banner
    @div_id = params[:div]
    @banner = Banner.find(params[:b])
  end

end
