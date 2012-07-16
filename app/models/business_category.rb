class BusinessCategory < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :search_keyword

  has_many :business_client
end
