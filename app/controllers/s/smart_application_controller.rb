class S::SmartApplicationController < ApplicationController
  layout "smart/application"
  
  before_filter :only_phone_user
  
  def only_phone_user
    if Rails.env == "production"
      redirect_to root_path unless Webcom::Browser.phone?(request)
    end
  end

end
