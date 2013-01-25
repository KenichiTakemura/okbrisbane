# -*- coding: utf-8 -*-
require 'singleton'

class SystemConfig
  include Singleton

  #SystemSetting
  attr_reader :post_expiry_length
  attr_reader :socialable
  attr_reader :issue_report_to
  attr_reader :admin_email
  attr_reader :contact_email
  attr_reader :top_page_ajax
  attr_reader :banner_clickable
  attr_reader :banner_ajaxable
  attr_reader :local_signin
  attr_reader :facebook_signin
  attr_reader :google_signin
  attr_reader :naver_signin
  attr_reader :twitter_signin

  
  def initialize
  end

  def load_data
    begin
    ss = SystemSetting.first
    if ss.present?
      @post_expiry_length = ss.post_expiry_length
      @socialable = ss.socialable
      @issue_report_to = ss.issue_report_to
      @admin_email = ss.admin_email
      @contact_email = ss.contact_email
      @top_page_ajax = ss.top_page_ajax
      @banner_clickable = ss.banner_clickable
      @banner_ajaxable = ss.banner_ajaxable
      @local_signin = ss.local_signin
      @facebook_signin = ss.facebook_signin
      @google_signin = ss.google_signin
      @naver_signin = ss.naver_signin
      @twitter_signin = ss.twitter_signin
      Rails.logger.debug("loadvalues: @post_expiry_length: #{@post_expiry_length}")
      Rails.logger.debug("loadvalues: @socialable: #{@socialable}")
      Rails.logger.debug("loadvalues: @issue_report_to: #{@issue_report_to}")
      Rails.logger.debug("loadvalues: @admin_email: #{@admin_email}")
      Rails.logger.debug("loadvalues: @contact_email: #{@contact_email}")
      Rails.logger.debug("loadvalues: @top_page_ajax: #{@top_page_ajax}")
      Rails.logger.debug("loadvalues: @banner_clickable: #{@banner_clickable}")
      Rails.logger.debug("loadvalues: @banner_ajaxable: #{@banner_ajaxable}")
      Rails.logger.debug("loadvalues: @local_signin #{@local_signin}")
      Rails.logger.debug("loadvalues: @facebook_signin #{@facebook_signin}")
      Rails.logger.debug("loadvalues: @google_signin #{@google_signin}")
      Rails.logger.debug("loadvalues: @naver_signin #{@naver_signin}")
      Rails.logger.debug("loadvalues: @twitter_signin #{@twitter_signin}")
    end
    rescue
    end
  end
  
  def post_expiry_length
    @post_expiry_length || SystemSetting.first.post_expiry_length
  end

  def socialable
    @socialable || SystemSetting.first.socialable
  end

  def issue_report_to
    @issue_report_to || SystemSetting.first.issue_report_to
  end

  def admin_email
    @admin_email || SystemSetting.first.admin_email
  end
  
  def contact_email
    @contact_email || SystemSetting.first.contact_email
  end
  
  def top_page_ajax
    @top_page_ajax || SystemSetting.first.top_page_ajax
  end
  
  def banner_clickable
    @banner_clickable || SystemSetting.first.banner_clickable
  end
  
  def banner_ajaxable
    @banner_ajaxable || SystemSetting.first.banner_ajaxable
  end
  
  def local_signin
    @local_signin || SystemSetting.first.local_signin
  end

  def facebook_signin
    @facebook_signin || SystemSetting.first.facebook_signin
  end 

  def google_signin
    @google_signin || SystemSetting.first.google_signin
  end
  
  def naver_signin
    @naver_signin || SystemSetting.first.naver_signin
  end
  
  def twitter_signin
    @twitter_signin || SystemSetting.first.twitter_signin
  end
end
