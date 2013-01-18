require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    load_system_config
    user = User.new(:email => "test@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane", :user_name => "Guest", :confirmed_at => Common.current_time)
    assert user.save, "Cannot save user"
  end
  
  test "anonymous" do
    user = User.new(:email => "anonymous@okbrisbane.com", :confirmed_at => Common.current_time)
    user.save(:validate => false)
    mypage = Mypage.find_by_mypagable_id(user)
    assert mypage
    user = User.find_by_email("anonymous@okbrisbane.com"), "anonymous not found"
    assert user
    assert user.first.okbrisbane_user?
  end
  
  test "same email" do
    user = User.first
    assert user.okbrisbane_user?
    user = User.new(:email => "test@test.com", :provider => User::PROVIDERS[:facebook], :uid => "12345", :password => "okbrisbane", :password_confirmation => "okbrisbane", :user_name => "Guest", :confirmed_at => Common.current_time)
    if !user.save
      Rails.logger.error("something wrong e => #{user.errors.full_messages}")
    end
  end
end
