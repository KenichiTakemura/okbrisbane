class Mypage < ActiveRecord::Base
  attr_accessible :is_public, :public_url, :locale
  belongs_to :mypagable, :polymorphic => true
  
  def add_post
    update_attribute(:num_of_post, self.num_of_post + 1)
  end
  
  after_initialize :set_default
  
  def set_default
    self.locale ||= Okvalue::DEFAULT_LOCALE  
  end
  
end
