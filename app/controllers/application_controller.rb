class ApplicationController < ActionController::Base

  protect_from_forgery

  #before_filter :authenticate_user!
  before_filter :set_locale
  #before_filter :opening_soon
  before_filter :hit, :get_admin_notice

  def initialize
    super
  end

  def hit
    key = Common.today
    Rails.logger.debug("hit from : #{request.remote_ip}")
    return if request.remote_ip.eql?(Okbrisbane::Application.config.my_host)
    unless session[key.to_sym]
      #Counter.instance.hit
      daily_hit = Rails.cache.read(:daily_hit).presence || 0
      daily_member_hit = Rails.cache.read(:daily_member_hit).presence || 0
      Rails.cache.write(:daily_hit, daily_hit + 1);
      if current_user
        #Counter.instance.member_hit
        Rails.cache.write(:daily_member_hit, daily_member_hit + 1);
      end
      session[key.to_sym] = true
      Rails.logger.debug("daily_hit: #{Rails.cache.read(:daily_hit)}")
      Rails.logger.debug("daily_member_hit: #{Rails.cache.read(:daily_member_hit)}")
    end
  end

  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale] || "ko"
  end
  
  def get_admin_notice
    @admin_notice = AdminNotice.current_notice.first
  end

  def opening_soon
    hit
    if !session[:granted]
      if !params[:k] || !params[:k].eql?(Okvalue::ACCESS_KEY)
        logger.info("BEFORE OPENNING ACCESS")
        render  :layout => "opening_soon", :file => "homes/opening_soon.html.erb"
      else
        session[:granted] = true
      end
    end
  end

  #def default_url_options(options={})
  #  logger.debug "default_url_options is passed options: #{options.inspect}\n"
  #  { :locale => I18n.locale }
  #end

  # if user is logged in, return current_user, else return anonymous_user
  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        logging_in
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  # find anonymous_user object associated with the current session,
  # creating one as needed
  def guest_user
    User.find(session[:guest_user_id].nil? ? session[:guest_user_id] = create_guest_user.id : session[:guest_user_id])
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  # redirect back to current page without oauth signin
  def after_sign_in_path_for(resource)
    logger.debug("after_sign_in_path_for")
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    if (request.referer == sign_in_url)
    super
    else
      request.referer || stored_location_for(resource) || root_path
    end
  end

  def after_sign_out_path_for(resource)
    logger.debug("after_sign_out_path_for")
    user_sign_out_path
  end

  rescue_from Exceptions::NotFoundError, :with => :record_not_found
  
  protected

  def record_not_found
    render :file => File.join("#{Rails.root}", 'public', '404.html'), :layout => false, :status => 404
  end

  private

  # Overwriting the sign_out redirect path method
  #def after_sign_out_path_for(resource_or_scope)
  #  root_path
  #end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # For example:
    # guest_comments = guest_user.comments.all
    # guest_comments.each do |comment|
    # comment.user_id = current_user.id
    # comment.save
    # end
  end

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
