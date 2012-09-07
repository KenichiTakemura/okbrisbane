class DailyHit < ActiveRecord::Base
  attr_accessible :day, :hit, :user_hit
  
  def hitting
    update_attribute(:hit, hit + 1)
  end
  
  def user_hitting
    update_attribute(:user_hit, user_hit + 1)    
  end

end
