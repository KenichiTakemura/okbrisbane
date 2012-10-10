require 'singleton'

class Counter 
  include Singleton
  require 'thread'
  
  attr_reader :daily_hit
  attr_reader :daily_member_hit
  attr_reader :lock
  
  def initialize
    @lock = Mutex.new
    @daily_hit = 0
    @daily_member_hit = 0
    Rails.logger.info("Counter ready #{@daily_hit} #{@daily_member_hit}")
  end

  def hit
    begin
      @lock.synchronize {
        @daily_hit += 1
      }
    rescue
      Rails.logger.warn("Hit something went wrong with #{$!}")
    end
    Rails.logger.info("daily_hit: #{@daily_hit}")
  end

  def member_hit
    begin
      @lock.synchronize {
        @daily_member_hit += 1
      }
    rescue
      Rails.logger.warn("Hit something went wrong with #{$!}")
    end
    Rails.logger.info("daily_member_hit: #{@daily_member_hit}")
  end
  
  def flash_hit
    Rails.logger.info("daily_hit: #{@daily_hit}")
    Rails.logger.info("daily_member_hit: #{@daily_member_hit}")
    begin
      @lock.synchronize {
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
        @daily_hit = 0
        @daily_member_hit = 0
      }
    rescue
      Rails.logger.warn("Flash_hit something went wrong with #{$!}")
    end
  end
  
end
