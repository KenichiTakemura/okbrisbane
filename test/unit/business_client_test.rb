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
    p = c.set_profile(body)
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
    p = c.set_profile(body)
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

end
