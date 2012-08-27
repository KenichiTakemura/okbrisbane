class SystemSetting < ActiveRecord::Base
  attr_accessible :post_expiry_length, :default => 30
  attr_accessible :socialable, :default => false
  attr_accessible :issue_report_to
  attr_accessible :admin_email
end
