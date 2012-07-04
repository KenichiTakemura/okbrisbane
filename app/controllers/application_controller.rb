class ApplicationController < ActionController::Base

  protect_from_forgery

  before_filter :set_locale
  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = params[:locale] || "ko"
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
  
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
  
  
  # Global Variables
  
  LOCALE_KO = "ko"
  LOCALE_EN = "en"
  LOCALE_ZHCN = "zh-CN"
  MAX_COMMENT_LENGTH = 1000
  MAX_POST_CONTENT_LENGTH = 1000
    
  DEFAULT_CATEGORY = 'na'
  DEFAULT_LOCALE = ApplicationController::LOCALE_KO
  VALID_DAYS = 30

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
end
