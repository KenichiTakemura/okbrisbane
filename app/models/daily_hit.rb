class DailyHit < ActiveRecord::Base
  attr_accessible :day, :hit, :user_hit
  
  def hitting(day_hit)
    self.hit += day_hit
    update_attribute(:hit, hit)
  end
  
  def user_hitting(day_user_hit)
    self.user_hit += day_user_hit
    update_attribute(:user_hit, user_hit)    
  end
  
  scope :month_for, lambda { |month| where("day like ?", "#{month}%") }

end
