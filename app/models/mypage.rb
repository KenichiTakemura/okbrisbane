class Mypage < ActiveRecord::Base
  attr_accessible :is_public, :public_url
  belongs_to :mypagable, :polymorphic => true
  
  def add_post
    update_attribute(:num_of_post, self.num_of_post + 1)
  end
  
end
