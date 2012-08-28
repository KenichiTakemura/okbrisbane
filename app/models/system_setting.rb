class SystemSetting < ActiveRecord::Base
  attr_accessible :post_expiry_length, :default => 30
  attr_accessible :socialable, :default => false
  attr_accessible :issue_report_to
  attr_accessible :admin_email
  
  validates_numericality_of :post_expiry_length, :only_integer => true, :greater_than => 0
  #validates_with EmailValidator, :attr => :issue_report_to
  #validates_with EmailValidator, :attr => :admin_email
  
end
