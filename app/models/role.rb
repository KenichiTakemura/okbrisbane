class Role < ActiveRecord::Base
  attr_accessible :role_name, :role_value
  belongs_to :rolable, :polymorphic => true
  
  R = Common.new_orderd_hash
  R[:none] = 0x00
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
  R[:all] = R[:user_all] | R[:other_all] | R[:group_all] 
  
  def add_role(name, value)
    self.role_name = name
    self.role_value = value
  end
  
  def assign(user)
    self.update_attribute(:rolable, user)
  end
  
  def has_role?(role_bit)
    logger.debug("has_role? #{role_value} #{role_bit}")
    v = (role_value & role_bit) == role_bit
    v
  end
  
  def disable_role
    update_attribute(:role_value, R[:none])
    true
  end
 
end
