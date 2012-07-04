require 'test_helper'

class MypageTest < ActiveSupport::TestCase

 def setup
    u = User.new(:email => "test@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane")
    assert u.save, "Cannot save user"
    u = User.first
    assert u, "User not found"
  end
  
  test "register a new user" do
     u = User.first
     assert m = Mypage.find_by_mypagable_id(u)
     assert !m.is_public
     assert_equal(m.blocked, 0)
     assert_equal(m.num_of_post, 0)
     assert !m.is_blacklist
     assert !m.nologin
  end
  
  test "destroy a user" do
      u = User.first
      u.destroy
      assert !Mypage.find_by_mypagable_id(u)
  end
  
  
end
