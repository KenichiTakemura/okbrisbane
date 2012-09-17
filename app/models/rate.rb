class Rate < ActiveRecord::Base
  attr_accessible :buy_or_sell, :issuedOn, :currency_to, :currency_from, :rate_a, :rate_b, :rate_c
  default_scope :order => 'id DESC'
  scope :rate_for, order.limit(6)
  
  default_scope :order => 'created_at DESC'
  
  def issued
    Common.date_format(issuedOn)
  end
  
end
