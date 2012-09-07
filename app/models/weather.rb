class Weather < ActiveRecord::Base
  attr_accessible :location, :issuedOn, :country, :max, :dateOn, :min, :forecast, :warning, :state
  
  scope :weather_for, lambda { |date,country| where("dateon = ? AND country = ?", date, country) }
  
    
  COUNTRIES = [[I18n.t(:australia),Okvalue::AUS],[I18n.t(:korea),Okvalue::KOR]]
  
  def issued
    Common.date_format(issuedOn)
  end
    
end
