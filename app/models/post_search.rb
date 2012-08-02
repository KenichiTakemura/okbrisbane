class PostSearch < ActiveRecord::Base
  attr_accessible :category
  attr_accessible :from
  attr_accessible :to
end
