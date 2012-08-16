class Role < ActiveRecord::Base
  attr_accessible :role_name, :role_value
  belongs_to :user
  
  ROLES[:view] = 1
  ROLES[:write] = 2
  ROLES[:delete] = 4
  ROLES[:all] = 255
  
end
