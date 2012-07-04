require 'test_helper'

class UserTest < ActiveSupport::TestCase

  #test "admin" do
  #  assert User.find_by_email('admin@okbrisbane.com')
  #end
  
  def setup
    user = User.new(:email => "test@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane")
    assert user.save, "Cannot save user"
  end
  
  test "anonymous" do
    user = User.new(:email => "anonymous@okbrisbane.com")
    user.save(:validate => false)
    mypage = Mypage.find_by_mypagable_id(user)
    assert mypage
    mypage.update_attribute(:nologin, true)
    assert mypage.save
    assert User.find_by_email("anonymous@okbrisbane.com"), "anonymous not found"
    assert user.nologin?
    #assert 
  end
  
  test "delete user" do
    user = User.first
    # post job
    
  
  end
end
