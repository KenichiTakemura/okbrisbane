require 'test_helper'

class ClientImageTest < ActiveSupport::TestCase
  test "client an image" do
    c = BusinessClient.new(:name => client)
    assert c.save, "Client not saved"
    ci = ClientImage.new()
    ci.avatar_file_name = "test.png"
    ci.avatar_content_type = "image/png"
    ci.avatar_content_type = 2000
    ci.avatar_content_type = Time.now
    assert ci.save, "Client Image not saved"
    ci.business_client = c
    assert ci.save, "Client Image with Client not saved"
    banner = Banner.create(:page => Style::PAGES[:home], :section => Style::SECTIONS[:header], :position => Style::POSITION[:north_west])
    assert banner.save, "Banner not saved"
    assert ci.update_attribute(:attached, banner), "Attached not saved"
  end
end
