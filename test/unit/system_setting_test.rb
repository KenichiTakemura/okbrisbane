require 'test_helper'

class SystemSettingTest < ActiveSupport::TestCase

  def setup
    ss = SystemSetting.new
    ss.post_expiry_length = 30
    ss.socialable = false
    ss.issue_report_to = "kenichi_takemura1976@yahoo.com"
    ss.admin_email = "info@okbrisbane.com"
    ss.save
  end

  test "change" do
    ss = SystemSetting.first
    ss.post_expiry_length = "test"
    assert !ss.save, "Saved"
    ss.post_expiry_length = 0
    assert !ss.save, "Saved"
    ss.post_expiry_length = 60
    assert ss.save, "Not Saved"
    assert_equal ss.post_expiry_length, 60
    ss.socialable = true
    assert ss.save, "Not Saved"
    ss.issue_report_to = ""
    assert !ss.save, "Saved"
    ss.issue_report_to = "test"
    assert !ss.save, "Saved"
    ss.issue_report_to = body
    assert !ss.save, "Saved"
    ss.issue_report_to = "@yahoo.com"
    assert !ss.save, "Saved"
    ss.issue_report_to = "test@yahoo.com"
    assert ss.save, "Not Saved"
    ss.admin_email = ""
    assert !ss.save, "Saved"
    ss.admin_email = "test"
    assert !ss.save, "Saved"
    ss.admin_email = body
    assert !ss.save, "Saved"
    ss.admin_email = "@yahoo.com"
    assert !ss.save, "Saved"
    ss.admin_email = "test@yahoo.com"
    assert ss.save, "Not Saved"
  end
end
