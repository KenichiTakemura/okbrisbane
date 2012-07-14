# -*- coding: utf-8 -*-
require 'test_helper'

class BusinessClientTest < ActiveSupport::TestCase
  def addClient
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name)
    assert c.save
    c
  end

  def addProfileImage(client)
    pi = BusinessProfileImage.new
    pi.avatar_file_name = image_file_name
    pi.avatar_content_type = "image/jpeg"
    pi.avatar_file_size = "123456"
    pi.avatar_updated_at = Time.now
    pi.attached_to(client)
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
    pi = BusinessProfileImage.new
    pi.avatar_file_name = image_file_name
    pi.avatar_content_type = "image/jpeg"
    pi.avatar_file_size = "123456"
    pi.avatar_updated_at = Time.now
    pi.attached_to(c)
    assert c.save
    Rails.logger.info("business_profile_image: #{c.business_profile_image}")
  end

  test "delete client" do
    c = addClient
    p = c.set_profile(body)
    addProfileImage(c)
    assert c.save
    assert c.destroy, "Not delete"
    assert !BusinessProfileImage.find_by_attached_id(c), "Image found"
    assert !BusinessProfile.find_by_profiled_to_id(c), "Profile found"
  end

end
