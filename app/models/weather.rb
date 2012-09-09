class Weather < ActiveRecord::Base
  attr_accessible :location, :issuedOn, :country, :max, :dateOn, :min, :forecast, :warning, :state
  
  scope :weather_for, lambda { |date,country| where("dateOn = ? AND country = ?", date, country) }
    
  COUNTRIES = [[I18n.t(:australia),Okvalue::AU],[I18n.t(:korea),Okvalue::KR]]
  
  def issued
    Common.date_format(issuedOn)
  end
    
end
