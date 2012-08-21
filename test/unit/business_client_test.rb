# -*- coding: utf-8 -*-
require 'test_helper'

class BusinessClientTest < ActiveSupport::TestCase

  def addClient
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name)
    assert c.save
    c
  end

  def addProfileImage(client)
    pi = BusinessProfileImage.new(:avatar => File.new("test/fixtures/images/companyprofile.jpg"))
    assert pi.attached_to(client)
  end

  test "add an invalid client" do
    c = BusinessClient.new()
    assert !c.save
    c = BusinessClient.new(:business_name => business_name)
    assert !c.save
    c = BusinessClient.create(:contact_name => contact_name)
    assert !c.save
  end

  test "add a client" do
    c = addClient
    assert c.save, "Not saved"
  end

  test "add a client and profile" do
    c = addClient
    p = c.set_profile(subject, body)
    assert c.save
    assert_equal(c.business_profile.body, body)
  end

  test "upload profile image" do
    c = addClient
    pi = BusinessProfileImage.new(:avatar => File.new("test/fixtures/images/companyprofile.jpg"))
    pi.attached_to(c)
    assert c.save
    Rails.logger.info("business_profile_image: #{c.business_profile_image}")
  end

  test "delete client" do
    c = addClient
    p = c.set_profile(subject, body)
    addProfileImage(c)
    assert c.save
    assert p.save
    assert c.destroy, "Not delete"
    assert !BusinessProfileImage.find_by_attached_id(c), "Image found"
    assert !BusinessProfile.find_by_business_client_id(c), "Profile found"
  end
  
  test "add and delete banners to a client" do
    c = addClient
    b1 = ClientImage.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert b1.attached_to(c)
    assert c.save
    assert_equal(b1.attached_type, BusinessClient.name)
    assert_equal(c.client_image.size, 1)
    b2 = ClientImage.new(:avatar => File.new("test/fixtures/images/banner2.jpg"))
    assert b2.attached_to(c)
    assert c.save
    assert_equal(b2.attached_type, BusinessClient.name)
    assert_equal(c.client_image.size, 2)
    assert b1.destroy
    assert_equal(c.client_image.size, 1)
    assert b2.destroy
    assert_equal(c.client_image.size, 0)
  end
  
  test "delete client with banner" do
    c = addClient
    b1 = ClientImage.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert b1.attached_to(c)
    assert c.save
    assert_equal(ClientImage.all.size, 1)
    assert c.destroy
    assert_equal(ClientImage.all.size, 0)
  end
  
  test "uniqueness of items" do
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name)
    assert c.save, "Not Saved"
    assert c.business_abn.nil?, "Not nil"
    assert c.business_url.nil?, "Not nil"
    c = BusinessClient.new(:business_name => "another_name", :contact_name => contact_name)
    assert c.save, "Not saved"
    BusinessClient.first.destroy
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name, :business_abn => "123 456 789", :business_url => "http://abc.com.au")
    assert c.save
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name)
    assert !c.save, "Saved"
    c = BusinessClient.new(:business_name => "another_name", :contact_name => contact_name, :business_abn => "123 456 789", :business_url => "http://def.com.au")
    assert !c.save, "Saved"
    c = BusinessClient.new(:business_name => "another_name", :contact_name => contact_name, :business_abn => "123 456 789 0", :business_url => "http://abc.com.au")
    assert !c.save, "Saved"
  end
  
  test "add client with business_category" do
    assert BusinessCategory.create(:en_name => "category", :display_name => I18n.t("category"))
    bc = BusinessCategory.first    
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name, :business_category => bc)
    assert c.save, "Not saved"    
  end
  
  test "add business_category" do
    bc = BusinessCategory.create(:en_name => "category", :display_name => I18n.t("category"))
    assert bc.save, "Category not saved"
    c = BusinessClient.new
    c.business_name = business_name
    c.contact_name = contact_name
    c.business_category = bc
    assert c.save, "Not saved"
    assert_equal(c.business_category.en_name,bc.en_name)
  end

end
