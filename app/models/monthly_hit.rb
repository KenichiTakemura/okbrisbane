class MonthlyHit < ActiveRecord::Base
  attr_accessible :day, :hit, :user_hit
  
  scope :month_for, lambda { |month| where("Month(day) = ?", month) }
    
end
