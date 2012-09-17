class Weather < ActiveRecord::Base
  attr_accessible :location, :issuedOn, :country, :max, :dateOn, :min, :forecast, :warning, :state
  
  default_scope :order => 'id DESC'
  scope :weather_for, lambda { |date,country| 
    if country.eql? Okvalue::AU
     where("dateOn <= ? AND country = ?", date, country).limit(WeatherConfig::AUSCityOrderList.size)
    else
     where("dateOn <= ? AND country = ?", date, country).limit(WeatherConfig::KORCityOrderList.size)
    end
  }    
  COUNTRIES = [[I18n.t(:australia),Okvalue::AU],[I18n.t(:korea),Okvalue::KR]]
  
  def forecast_for
    Common.date_format(dateOn)
  end
  
  def issued
    Common.date_format(issuedOn)
  end
    
end
