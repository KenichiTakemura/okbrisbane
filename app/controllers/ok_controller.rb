class OkController < ApplicationController

  before_filter :hit

  require 'thread'

  def initialize
    super
    @lock = Mutex.new
  end
  
  def hit
     key = Time.now.utc.strftime("%Y%m%d")
     logger.debug("key: #{key} session[key]: #{session[key.to_sym]}")
     unless session[key.to_sym]
       @lock.synchronize {
         hit_day = DailyHit.find_by_day(key)
         hit_day ||= DailyHit.new(:day => key)
         hit_day.hit += 1
         hit_day.save
       }
       session[key.to_sym] = true
    end
  end

  protected

  MODELS = {:p_job => Job,
    :p_buy_and_sell => BuyAndSell,
    :p_well_being => WellBeing,
    :p_estate => Estate,
    :p_motor_vehicle => MotorVehicle,
    :p_business => Business,
    :p_accommodation => Accommodation,
    :p_law => Law, 
    :p_tax => Tax,
    :p_study => Study,
    :p_immig => Immigration,
    :p_yellowpage => BusinessClient,
    :p_sponsor => BusinessClient,
    :p_mypage => Mypage
  }
  
end
