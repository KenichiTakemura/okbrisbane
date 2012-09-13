require 'test_helper'

class BannerTest < ActiveSupport::TestCase
  
  test "style" do
    assert_equal Style.pages.size, 19
    assert_equal Style.banner_pages.size, 18
    assert_equal Style.sections.size, 3
    assert_equal Style.pageid_value("Job"), 4
    assert_equal Style.pageid_key(:p_job), 4
    assert_equal Style.pagename("4"), "Job"
    assert_equal Style.pagename(4), "Job"
    assert_equal Style.pagename_sym("4"), :p_job
    assert_equal Style.pagename_sym(4), :p_job
    assert_equal Style.sectionid(:s_header), 1
    assert_equal Style.sectionname("1"), "s_header"
    assert_equal Style.sectionname(1), "s_header"
    assert_equal Style.sectionname_sym("1"), :s_header
    assert_equal Style.sectionname_sym(1), :s_header
    assert_equal Style.page(:p_job), "Job"
    assert_equal Style.page("p_job"), "Job"
    assert_equal Style.section(:s_header), "s_header"
    assert_equal Style.section("s_header"), "s_header"
    assert_equal Style.m2s("Job"), :p_job
    assert_not_equal Style.getEffect("Home", :s_body, 1), ""
    assert_not_equal Style.getEffect("Job", :s_header, 1), ""
    assert_equal Style.getEffect("Job", :s_body, 1), ""
    
    i = 1
    Style.pages.each do |key,value|
      assert_equal Style.pageid_key(key), i
      i += 1
    end
    
  end
  
  def client_with_banners
    c = BusinessClient.new(:business_name => business_name, :contact_name => contact_name)
    assert c.save
    b1 = ClientImage.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert b1.attached_to(c)
    assert c.save
    assert_equal(b1.attached_type, BusinessClient.name)
    assert_equal(c.client_image.size, 1)
    b2 = ClientImage.new(:avatar => File.new("test/fixtures/images/banner2.jpg"))
    assert b2.attached_to(c)
    assert c.save
    assert_equal(b2.attached_type, BusinessClient.name)
    c
  end

  def create_banner
    Style.banner_pages.each do |key, value|
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_header),
      :position_id => 1,
      :div_width => 500, :div_height => 60, :img_width => 500,
      :img_height => 60, :style => 'position:relative;float:right;top:0px;')
      Banner.create(:page_id => Style.pageid_key(key),
      :section_id => Style.sectionid(:s_header),
      :position_id => 2,
      :div_width => 710, :div_height => 120, :img_width => 710, :img_height => 120,
      :style => 'position:relative;float:right;right:0px')
    end
  end

  def getBanner(p,s,a)
    Banner.all.each do |banner|
      if banner.page_id == Style.pageid_key(p) && banner.section_id == Style.sectionid(s) && banner.position_id.to_i == a.to_i
        return banner
      end
    end
    raise "No banner space found for #{p} >> #{s} >> #{a}"
  end

  test "add images" do
    c = client_with_banners
    create_banner
    banner = getBanner(:p_home, :s_header, 1)
    assert !banner.id.nil?
    assert_equal(c.client_image.size, 2)
    c.client_image.each do |image|
      assert banner.client_image << image, "Not attach image to banner"
    end
    c.client_image.each do |image|
      assert_equal(image.banner.size, 1)
      assert_equal(image.banner[0].id, banner.id)
    end
    assert_equal(banner.client_image.size, 2)
    assert_equal(BannerImage.all.size, 2)
    BannerImage.all.each_with_index do |bi,i|
      assert c.client_image.include?(bi.client_image), "Not found #{bi.client_image.id}"
      assert bi.banner_id == banner.id, "Banner not found"
    end
    image = banner.client_image[0]
    banner.client_image.delete(image)
    assert_equal(banner.client_image.size, 1)
    assert_equal(BannerImage.all.size, 1)
    assert_equal(c.client_image.size, 2)
  end

  test "delete image" do
    c = client_with_banners
    create_banner
    banner = getBanner(:p_home, :s_header, 1)
    c.client_image.each do |image|
      assert banner.client_image << image, "Not attach image to banner"
    end
    Rails.logger.debug("BannerImage(before): #{BannerImage.all}")
    assert_equal(BannerImage.all.size, 2)
    assert_equal(banner.client_image.size, 2)
    assert_equal(c.client_image.size, 2)
    image = c.client_image[0]
    Rails.logger.debug("Image: #{image} is deleted")
    image.destroy
    Rails.logger.debug("BannerImage(after): #{BannerImage.all}")
    assert_equal(BannerImage.all.size, 1)
    assert_equal(banner.client_image.size, 1)
    assert_equal(BusinessClient.first.client_image.size, 1)
  end

  test "add images to banners" do
    c = client_with_banners
    create_banner
    banner1 = getBanner(:p_home, :s_header, 1)
    banner2 = getBanner(:p_signup, :s_header, 1)
    c.client_image.each do |image|
      assert banner1.client_image << image, "Not attach image to banner"
      assert banner2.client_image << image, "Not attach image to banner"
    end
    Rails.logger.debug("BannerImage(before): #{BannerImage.all}")
    assert_equal(BannerImage.all.size, 4)
    assert_equal(banner1.client_image.size, 2)
    assert_equal(banner2.client_image.size, 2)
    assert_equal(c.client_image.size, 2)
  end

end
