class MonthlyHit < ActiveRecord::Base
  attr_accessible :month, :hit, :user_hit
  
  scope :year_for, lambda { |year| where("Year(month) = ?", year) }
    
end
