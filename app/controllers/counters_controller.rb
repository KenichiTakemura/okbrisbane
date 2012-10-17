class CountersController < ApplicationController

  before_filter :filter
  def filter
    raise Exceptions::NotFoundError.new unless request.remote_ip == Okbrisbane::Application.config.my_host
  end

  def batch
    begin
      flash_hit
      render :text => "OK", :status => 200
    rescue
      render :text => "NG", :status => 500
    end
  end

  private

  def flash_hit
    @daily_hit = Rails.cache.read(:daily_hit).presence || 0
    @daily_member_hit = Rails.cache.read(:daily_member_hit).presence || 0
    Rails.logger.info("flash_hit daily_hit: #{@daily_hit}")
    Rails.logger.info("flash_hit daily_member_hit: #{@daily_member_hit}")
    begin
      key = Common.today
      hit_for_day = DailyHit.find_by_day(key)
      if !hit_for_day.present?
        hit_for_day = DailyHit.new(:day => key)
        hit_for_day.hit = @daily_hit
        hit_for_day.user_hit = @daily_member_hit
        hit_for_day.save
      else
        hit_for_day.hitting(@daily_hit)
        hit_for_day.user_hitting(@daily_member_hit)
      end
      Rails.cache.write(:daily_hit, 0);
      Rails.cache.write(:daily_member_hit, 0);
    rescue
      Rails.logger.warn("Flash_hit something went wrong with #{$!}")
    end
  end

end