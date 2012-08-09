class SystemSetting < ActiveRecord::Base
  attr_accessible :post_expiry_length, :default => 30

end
