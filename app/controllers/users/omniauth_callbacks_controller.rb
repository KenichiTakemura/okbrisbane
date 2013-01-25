class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    logger.info("OmniauthCallback facebook #{request.env["omniauth.auth"]}")
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.present? && @user.persisted?
      logger.info("User signed in via Facebook")
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      #redirect_to new_flyer_registration_url
      redirect_to root_path
    end
  end

  def google_oauth2
    logger.info("OmniauthCallback google_oauth2 #{request.env["omniauth.auth"]}")
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)
    if @user.present? && @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      #redirect_to new_flyer_registration_url
      redirect_to root_path
    end
  end

  def naver
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    logger.info("OmniauthCallback naver #{request.env["omniauth.auth"]}")
    @user = User.find_for_naver_oauth(request.env["omniauth.auth"], current_user)

  end

  # Override
  def failure
    logger.error("OmniauthCallbacksController failure_message: #{failure_message}")
    set_flash_message :alert, :failure, :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    #flash[:alert] = I18n.t "devise.omniauth_callbacks.flyer.failure", :kind => failed_strategy.name.to_s.humanize, :reason => failure_message
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  def after_omniauth_failure_path_for(scope)
    logger.warn("after_omniauth_failure_path_for #{scope}")
    root_path
  end
end