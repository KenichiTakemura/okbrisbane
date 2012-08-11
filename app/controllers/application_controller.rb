class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_locale
  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale] || "ko"
  end

  #def default_url_options(options={})
  #  logger.debug "default_url_options is passed options: #{options.inspect}\n"
  #  { :locale => I18n.locale }
  #end

  # if user is logged in, return current_user, else return anonymous_user
  def current_or_anonymous_user
    if current_user
      if session[:anonymous_user_id]
        logging_in
        anonymous_user.destroy
        session[:anonymous_user_id] = nil
      end
      current_user
    else
      anonymous_user
    end
  end

  # find anonymous_user object associated with the current session,
  # creating one as needed
  def anonymous_user
    User.find(session[:anonymous_user_id].nil? ? session[:anonymous_user_id] = create_anonymous_user.id : session[:anonymous_user_id])
  end

  # https://github.com/plataformatec/devise/wiki/How-To:-redirect-to-a-specific-page-on-successful-sign-in
  # redirect back to current page without oauth signin
  def after_sign_in_path_for(resource)
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

  protected

  def _makeImageList(feed_list, limit)
    image_list = Array.new
    feed_list.each_with_index do |feed, i|
      if !feed.feeded_to.image.empty?
      image_list.push(feed)
      feed_list.slice!(i)
      break if(image_list.size >= limit)
      end
    end
    return feed_list, image_list
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

  def create_anonymous_user
    u = User.find_by_email("anonymous@okbrisbane.com")
    u
  end

  def post_expiry
    system_setting = SystemSetting.first
    Time.now + system_setting.post_expiry_length.days
  end

  def find_lastid(board_list)
    if !board_list.nil? && !board_list.empty?
    lastid = board_list.last.id
    else
      lastid = nil
    end
    logger.debug("@lastid: #{@lastid}")
    lastid
  end

end
