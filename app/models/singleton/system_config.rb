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
end
