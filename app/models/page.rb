class Page < ActiveRecord::Base
  attr_accessible :name
  
  has_many :banner, :dependent => :destroy
  
end
