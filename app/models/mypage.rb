class Mypage < ActiveRecord::Base
  attr_accessible :is_public, :public_url
  belongs_to :mypagable, :polymorphic => true
  
end
