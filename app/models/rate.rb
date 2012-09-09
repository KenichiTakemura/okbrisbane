class Rate < ActiveRecord::Base
  attr_accessible :buy_or_sell, :issuedOn, :currency_to, :currency_from, :dateOn, :rate_a, :rate_b, :rate_c
  
  scope :rate_for, lambda { |date,country| where("dateOn = ? AND country = ?", date, country) }
    
  def issued
    Common.date_format(issuedOn)
  end
  
end
