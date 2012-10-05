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
      Rails.logger.debug("loadvalues: @post_expiry_length: #{@post_expiry_length}")
      Rails.logger.debug("loadvalues: @socialable: #{@socialable}")
      Rails.logger.debug("loadvalues: @issue_report_to: #{@issue_report_to}")
      Rails.logger.debug("loadvalues: @admin_email: #{@admin_email}")
      Rails.logger.debug("loadvalues: @contact_email: #{@contact_email}")
      Rails.logger.debug("loadvalues: @top_page_ajax: #{@top_page_ajax}")
      Rails.logger.debug("loadvalues: @banner_clickable: #{@banner_clickable}")
      Rails.logger.debug("loadvalues: @banner_ajaxable: #{@banner_ajaxable}")
    end
    rescue
    end
  end

  def post_expiry_length
    Rails.logger.debug("getSystemConfig @post_expiry_length: #{@post_expiry_length}")
    @post_expiry_length
  end

  def socialable
    Rails.logger.debug("getSystemConfig @socialable: #{@socialable}")
    @socialable
  end

  def issue_report_to
    Rails.logger.debug("getSystemConfig @issue_report_to: #{@issue_report_to}")
    @issue_report_to
  end

  def admin_email
    Rails.logger.debug("getSystemConfig @admin_email: #{@admin_email}")
    @admin_email
  end

  def contact_email
    Rails.logger.debug("getSystemConfig @contact_email: #{@contact_email}")
    @contact_email
  end

  def top_page_ajax
    Rails.logger.debug("getSystemConfig @top_page_ajax: #{@top_page_ajax}")
    @top_page_ajax
  end

  def banner_clickable
    Rails.logger.debug("getSystemConfig @banner_clickable: #{@banner_clickable}")
    @banner_clickable
  end
  
  def banner_ajaxable
    Rails.logger.debug("getSystemConfig @banner_ajaxable: #{@banner_ajaxable}")
    @banner_ajaxable
  end

end
