class BuyAndSellsController < PostsController
  
  before_filter :filter
  
  def filter
    @okpage = :p_buy_and_sell
  end
  
  def create
    logger.debug("create buy_and_sell post by #{current_user}")
    create_post(BuyAndSell, :buy_and_sell)
  end
    
end