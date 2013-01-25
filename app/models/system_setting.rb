class SystemSetting < ActiveRecord::Base
  attr_accessible :post_expiry_length, :default => 30
  attr_accessible :socialable, :default => false
  attr_accessible :issue_report_to
  attr_accessible :admin_email
  attr_accessible :contact_email
  attr_accessible :top_page_ajax
  attr_accessible :banner_clickable
  attr_accessible :banner_ajaxable
  attr_accessible :local_signin
  attr_accessible :facebook_signin
  attr_accessible :google_signin
  attr_accessible :naver_signin
  attr_accessible :twitter_signin
  
  validates_numericality_of :post_expiry_length, :only_integer => true, :greater_than => 0
  validates_format_of :issue_report_to, :with => Okvalue::EMAIL_REGEXP
  validates_format_of :admin_email, :with => Okvalue::EMAIL_REGEXP
  validates_format_of :contact_email, :with => Okvalue::EMAIL_REGEXP
  
end
