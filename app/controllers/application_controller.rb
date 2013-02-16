class ApplicationController < ActionController::Base

  protect_from_forgery

  #before_filter :set_locale
  before_filter :hit

  def initialize
    super
  end

  def hit
    key = Webcom::DateUtil.today
    b = statistics(request)
    if !request.remote_ip.eql?(Okbrisbane::Application.config.my_host)
      unless session[key.to_sym]
        daily_hit = Rails.cache.read(:daily_hit).presence || 0
        daily_member_hit = Rails.cache.read(:daily_member_hit).presence || 0
        Rails.cache.write(:daily_hit, daily_hit + 1);
        if current_user
          Rails.cache.write(:daily_member_hit, daily_member_hit + 1);
        end
        session[key.to_sym] = true
      end
    end
    if Webcom::Browser.from_phone?(b)
      redirect_to smarts_path
    end
  end
  
  def statistics(request)
    b = Webcom::Browser.browser_detection(request,nil)
    begin
      stat = Rails.cache.read(:browser_stat).presence || BrowserLog.new
    rescue
      stat = BrowserLog.find_by_day(Common.today.to_i) || BrowserLog.new
    end
    case b
    when Webcom::Browser::NOT_DETECTED
      stat.pc_other += 1
    when Webcom::Browser::Safari
      stat.pc_sf += 1
    when Webcom::Browser::Chrome
      stat.pc_ch += 1
    when Webcom::Browser::Firefox
      stat.pc_ff += 1
    when Webcom::Browser::Opera
      stat.pc_op += 1
    when Webcom::Browser::MSIE
      stat.pc_ie += 1
    when Webcom::Browser::MO_NOT_DETECTED
      stat.mo_other += 1
    when Webcom::Browser::MO_Safari
      stat.mo_sf += 1
    when Webcom::Browser::MO_Chrome
      stat.mo_ch += 1
    when Webcom::Browser::MO_Firefox
      stat.mo_ff += 1
    when Webcom::Browser::MO_Opera
      stat.mo_op += 1
    when Webcom::Browser::MO_MSIE
      stat.mo_ie += 1
    end
    begin
      Rails.cache.write(:browser_stat, stat)
      Rails.logger.debug("browser_stat: #{Rails.cache.read(:browser_stat)}")
    rescue
      stat.save
    end
    b
  end

  #def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    #I18n.locale = params[:locale] || "ko"
  #end
  
  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  # redirect back to current page without oauth signin
  def after_sign_in_path_for(resource)
    logger.info("after_sign_in_path_for #{resource}")
    if !resource.agreed?
      logger.info("User has NOT agreed")
      agreement_path
    else
      logger.info("User has agreed request.referer: #{request.referer}")      
      sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
      agreement_url = url_for(:action => 'agreememnt_required', :controller => 'member_managements', :only_path => false, :protocol => 'http')
      if (request.referer == sign_in_url || request.referer == agreement_url)
        super
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end
  end

  def after_sign_out_path_for(resource)
    logger.debug("after_sign_out_path_for")
    user_sign_out_path
  end

  rescue_from Webcom::Exceptions::NotFoundError, :with => :record_not_found
  
  protected

  def record_not_found
    render :file => File.join("#{Rails.root}", 'public', '404.html'), :layout => false, :status => 404
  end

  private


  def create_guest_user
    u = User.find_by_email("okbrisbane_guest@okbrisbane.com")
    u
  end

  def post_expiry
    Common.current_time + SystemConfig.instance.post_expiry_length.days
  end

  def top_page_ajaxable?
    SystemConfig.instance.top_page_ajax    
  end

  def find_lastid(board_list, board_image_list=nil)
    if board_list.present? && board_image_list.present?
      l_lastid = board_list.last.id
      i_lastid = board_image_list.last.id
      logger.debug("l_lastid: #{l_lastid} i_lastid: #{i_lastid}")
      lastid = (l_lastid > i_lastid) ? i_lastid : l_lastid
    elsif board_list.present?
      lastid = board_list.last.id
    elsif board_image_list.present?
      lastid = board_image_list.last.id
    else    
      lastid = nil
    end
    logger.debug("find_lastid: #{lastid}")
    lastid
  end

end
