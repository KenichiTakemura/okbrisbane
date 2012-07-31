class OkboardsController < OkController

  before_filter :_before_

  $okboard_map = Hash.new
 
  def _before_
    raise "Bad Request" if params[:v].nil?
    v = params[:v]
    logger.debug("$okboard_map: #{$okboard_map}")
    if !$okboard_map[v.to_sym].nil?
      @board = $okboard_map[v.to_sym]
      logger.debug("Found: #{@board} v: #{v}")
    else
      Style::PAGES.each do |key, value|
        logger.debug("value: #{value.crypt("okboard")} v: #{v}")
        if value.crypt("okboard").eql? v
          @board = value
          $okboard_map[v.to_sym] = value
          logger.debug("Added: #{@board} v: #{v}")
          break
        end
      end
    end
  end

  def index
    logger.debug("v: #{@board}")
    case @board
    when Style::PAGES[:p_job]
      @okpage = :p_job
    when Style::PAGES[:p_buy_and_sell]
      @okpage = :p_buy_and_sell
    when Style::PAGES[:p_wellbeing]
      @okpage = :p_wellbeing
    when Style::PAGES[:p_study]
      @okpage = :p_study
    when Style::PAGES[:p_immig]
      @okpage = :p_immig   
    when Style::PAGES[:p_estate]
      @okpage = :p_estate   
    when Style::PAGES[:p_law]
      @okpage = :p_law  
    when Style::PAGES[:p_tax]
      @okpage = :p_tax  
    when Style::PAGES[:p_yellowpage]
      @okpage = :p_yellowpage        
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jobs }
    end
    
  end

end
