require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  test "add contact" do
    c = Contact.new(:user_name => contact_name, :email => emailaddress, :phone => phonenumber1, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert c.save
    assert_equal(c.phone,phonenumber1)
    c = Contact.new(:user_name => contact_name, :email => emailaddress, :phone => phonenumber2, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert c.save
    assert_equal(c.phone,phonenumber2)
    c =  Contact.new(:user_name => contact_name, :email => emailaddress, :phone => phonenumber3, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert c.save
    assert_equal(c.phone,phonenumber3)
    c =  Contact.new(:user_name => contact_name, :email => emailaddress, :phone => phonenumber4, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert c.save
    assert_equal(c.phone,phonenumber4)
    c =  Contact.new(:user_name => contact_name, :email => emailaddress, :phone => phonenumber5, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert c.save
    assert_equal(c.phone,phonenumber5)
    c =  Contact.new(:user_name => contact_name, :email => emailaddress, :phone => phonenumber6, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert c.save
    assert_equal(c.phone,phonenumber6)
    c = Contact.new(:user_name => contact_name)
    assert !c.save
    c = Contact.new(:email => emailaddress)
    assert !c.save
    c = Contact.new(:phone => phonenumber1)
    assert !c.save
    c = Contact.new(:type => Okvalue::CONTACT_BANNER)
    assert !c.save
    c = Contact.new(:body => body)
    assert !c.save
    c = Contact.new(:user_name => "contact_name", :email => "emailaddress", :phone => phonenumber1, :type => Okvalue::CONTACT_BANNER, :body => body)
    assert !c.save
    c = Contact.new(:user_name => "contact_name", :email => emailaddress, :phone => "phonenumber1", :type => Okvalue::CONTACT_BANNER, :body => body)
    assert !c.save
  end

end
