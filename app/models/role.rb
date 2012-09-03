class Role < ActiveRecord::Base
  attr_accessible :role_name, :role_value
  belongs_to :rolable, :polymorphic => true
  
  R = Hash.new
  R[:other_r] = 0x01
  R[:other_w] = 0x02
  R[:other_x] = 0x04
  R[:other_all] = 0x07
  R[:group_r] = 0x10
  R[:group_w] = 0x20
  R[:group_x] = 0x40
  R[:group_all] = 0x70
  R[:user_r] = 0x100
  R[:user_w] = 0x200
  R[:user_x] = 0x400
  R[:user_all] = 0x700
  
  def add_role(name, value)
    self.name = name
    self.value = value
  end
  
  def assign(user)
    self.update_attribute(:rolable, user)
  end
  
  def has_role?(page, role_bit)
    role_name.eql?(Style.page(page)) && role_value | role_bit
  end
 
end
