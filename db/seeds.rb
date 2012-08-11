# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Banner.delete_all
BusinessClient.delete_all
BusinessProfile.delete_all
BusinessProfileImage.delete_all
SystemSetting.delete_all

# Users
User.create(:email => "kenichi_takemura1976@yahoo.com", :password => 'kenichi123', :password_confirmation => 'kenichi123', :first_name => "켄이치", :last_name => "다케무라")
anonymous = User.new(:email => "anonymous@okbrisbane.com", :last_name => "Anonymous")
anonymous.save(:validate => false)
guest = User.new(:email => "guest@okbrisbane.com", :last_name => "Guest")
guest.save(:validate => false)

# OKBRISBANE 
ok = BusinessClient.create(:business_name => "OKBRISBANE", :business_abn => "98 152 354 768", :business_address => 'Shop 3 6 Zamia Street Sunny Bank QLD 4109', :business_url => 'http://www.okbrisbane.com', :business_phone => '07-3345-3256', :business_fax => '07-3343-8558', :business_email => 'info@okbrisbane.com', :contact_name => 'Elliott Joo')
ok.build_business_profile(:body => 'OKBRISBANE rocks!')
ok.save

# SystemSetting
ss = SystemSetting.new
ss.post_expiry_length = 30
ss.save

# Banner

Style::PAGES.each do |key, value|
  ## Header
  if value.eql? Style.page(:p_home)
    effect = Banner::E_SLIDE
  else
    effect = Banner::E_FIX
  end
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_header),
  :position_id => 1,
  :div_width => 500, :div_height => 60, :img_width => 500,
  :img_height => 60, :style => 'position:relative;float:right;top:0px;',
  :effect => Banner::E_FIX)
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_header),
  :position_id => 2,
  :div_width => 710, :div_height => 120, :img_width => 710, :img_height => 120,
  :style => 'position:relative;float:right;right:0px',
  :effect => effect)
  if value.eql? Style.page(:p_home)
    is_disabled = false
  else
    is_disabled = true
  end
  ## Background
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_background),
  :position_id => 1,
  :div_width => 160, :div_height => 800,
  :img_width => 160, :img_height => 800,
  :style => 'position:absolute;top:100px;left:-165px',
  :is_disabled => is_disabled)
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_background),
  :position_id => 2,
  :div_width => 160, :div_height => 800,
  :img_width => 160, :img_height => 800,
  :style => 'position:absolute;top:100px;right:-165px',
  :is_disabled => is_disabled)
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_background),
  :position_id => 3,
  :div_width => 160, :div_height => 800,
  :img_width => 160, :img_height => 800,
  :style => 'position:absolute;top:950px;left:-165px',
  :is_disabled => is_disabled)
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_background),
  :position_id => 4,
  :div_width => 160, :div_height => 800,
  :img_width => 160, :img_height => 800,
  :style => 'position:absolute;top:950px;right:-165px',
  :is_disabled => is_disabled)
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_background),
  :position_id => 5,
  :div_width => 160, :div_height => 800,
  :img_width => 160, :img_height => 800,
  :style => 'position:absolute;top:1800px;left:-165px',
  :is_disabled => is_disabled)
  Banner.create(:page_id => Style.pageid(key),
  :section_id => Style.sectionid(:s_background),
  :position_id => 6,
  :div_width => 160, :div_height => 800,
  :img_width => 160, :img_height => 800,
  :style => 'position:absolute;top:1800px;right:-165px',
  :is_disabled => is_disabled)

end
# Home
_page = :p_home
## Body
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id =>1,
:div_width => 650, :div_height => 400,
:img_width => 650, :img_height => 380,
:style => 'position:relative;float:left;top:0px',
:effect => Banner::E_SLIDE);
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 2,
:div_width => 320, :div_height => 200,
:img_width => 320, :img_height => 200,
:style => 'position:relative;top:0px;right:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 3,
:div_width => 630, :div_height => 110,
:img_width => 120, :img_height => 100,
:style => 'position:relative;float:left;top:0px;left:10px;right:10px ',
:effect => Banner::E_MSLIDE);
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 4,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:left;top:0px;left:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 5,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:left;top:0px;left:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 6,
:div_width => 650, :div_height => 160,
:img_width => 210, :img_height => 150,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 7,
:div_width => 650, :div_height => 160,
:img_width => 210, :img_height => 150,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 8,
:div_width => 650, :div_height => 160,
:img_width => 210, :img_height => 150,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 9,
:div_width => 650, :div_height => 160,
:img_width => 210, :img_height => 150,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Style.pageid(_page),
:section_id => Style.sectionid(:s_body),
:position_id => 10,
:div_width => 650, :div_height => 160,
:img_width => 210, :img_height => 150,
:style => 'position:relative;float:right;top:0px;left:0px;')
# Body
[:p_signin,:p_signup].each do |page|
Banner.create(:page_id => Style.pageid(page),
:section_id => Style.sectionid(:s_body),
  :position_id => 1,
  :div_width => 220, :div_height => 130,
  :img_width => 220, :img_height => 130,
  :style => 'position:relative;float:left;top:0px',
  :is_disabled => true)
end
[:p_job,:p_buy_and_sell,:p_wellbeing,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation].each do |page|
Banner.create(:page_id => Style.pageid(page),
:section_id => Style.sectionid(:s_body),
  :position_id => 1,
  :div_width => 220, :div_height => 130,
  :img_width => 220, :img_height => 130,
  :style => 'position:relative;float:left;top:0px')
end
[:p_signin,:p_signup,:p_signout, :p_job,:p_buy_and_sell,:p_wellbeing,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation].each do |page|
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 2,
  :div_width => 220, :div_height => 150,
  :img_width => 220, :img_height => 150,
  :style => 'position:relative;float:left;top:0px')
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 3,
  :div_width => 220, :div_height => 150,
  :img_width => 220, :img_height => 150,
  :style => 'position:relative;float:left;top:0px')
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 4,
  :div_width => 220, :div_height => 150,
  :img_width => 220, :img_height => 150,
  :style => 'position:relative;float:left;top:0px')
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 5,
  :div_width => 740, :div_height => 150,
  :img_width => 740, :img_height => 150,
  :style => 'position:relative;float:left;top:0px')
end
# Buy and Sell Related
[:p_estate,:p_motor_vehicle,:p_business,:p_accommodation].each do |page|
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 6,
  :div_width => 240, :div_height => 150,
  :img_width => 240, :img_height => 150,
  :style => 'position:relative;float:left;top:0px')
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 7,
  :div_width => 240, :div_height => 150,
  :img_width => 240, :img_height => 150,
  :style => 'position:relative;float:left;top:0px;left:5px')
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 8,
  :div_width => 240, :div_height => 150,
  :img_width => 240, :img_height => 150,
  :style => 'position:relative;float:left;top:0px;left:10px')
end
# Signin
[:p_signin].each do |page|
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 6,
  :div_width => 360, :div_height => 500,
  :img_width => 360, :img_height => 500,
  :style => 'position:relative;float:left;top:0px')
end
# Signout
[:p_signout].each do |page|
  Banner.create(:page_id => Style.pageid(page),
  :section_id => Style.sectionid(:s_body),
  :position_id => 6,
  :div_width => 500, :div_height => 600,
  :img_width => 500, :img_height => 600,
  :style => 'position:relative;float:left;top:0px')
end