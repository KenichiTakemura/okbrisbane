# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Page.delete_all
Section.delete_all
Banner.delete_all
SystemSetting.delete_all

# Users
User.create(:email => "kenichi_takemura1976@yahoo.com", :password => 'kenichi123', :password_confirmation => 'kenichi123')
anonymous = User.new(:email => "anonymous@okbrisbane.com")
anonymous.save(:validate => false)
guest = User.new(:email => "guest@okbrisbane.com")
guest.save(:validate => false)

# Page
Style::PAGES.each do |key, value|
  Page.create(:name => value)
end
# Section
Style::SECTIONS.each do |key, value|
  Section.create(:name => value)
end
# SystemSetting
ss = SystemSetting.new
ss.image_thumbnail_size = "100x100>"
ss.image_max_size_in_kb = "50000"
ss.attach_acceptable_extention = 'image/jpeg,image/png,image/gif'
ss.attach_storage_path = ''
ss.business_profile_picture_size = "500x400>"
ss.save

# Banner
# Home
_page = :p_home
## Header
Style::PAGES.each do |key, value|
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:s_header]).id,
  :position_id => 1,
  :div_width => 500, :div_height => 60, :img_width => 500,
  :img_height => 60, :style => 'position:relative;float:right;top:0px;')
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:s_header]).id,
  :position_id => 2,
  :div_width => 710, :div_height => 120, :img_width => 710, :img_height => 120,
  :style => 'position:relative;float:right;right:0px')
end
## Background
Style::PAGES.each do |key, value|
  if value.eql? Style::PAGES[:p_home]
    enabled = true 
  else
    enabled = false
  end
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:s_background]).id,
  :position_id => 1,
  :div_width => 160, :div_height => 750,
  :img_width => 160, :img_height => 750,
  :style => 'position:absolute;top:100px;left:-165px',
  :enabled => enabled)
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:s_background]).id,
  :position_id => 2,
  :div_width => 160, :div_height => 750,
  :img_width => 160, :img_height => 750,
  :style => 'position:absolute;top:100px;right:-165px',
  :enabled => enabled)
end
## Body
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id =>1,
:div_width => 650, :div_height => 380,
:img_width => 650, :img_height => 380,
:style => 'position:relative;float:left;top:0px')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 2,
:div_width => 320, :div_height => 200,
:img_width => 320, :img_height => 200,
:style => 'position:relative;top:0px;right:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 3,
:div_width => 650, :div_height => 110,
:img_width => 120, :img_height => 100,
:style => 'position:relative;float:left;top:0px;left:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 4,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:left;top:0px;left:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 5,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:left;top:0px;left:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 6,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 7,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 8,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:right;top:0px;left:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id => 9,
:div_width => 650, :div_height => 130,
:img_width => 210, :img_height => 120,
:style => 'position:relative;float:right;top:0px;left:0px;')
# Signin
_page = :p_signup
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id =>1,
:div_width => 200, :div_height => 150,
:img_width => 200, :img_height => 150,
:style => 'position:relative;float:left;top:0px')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id =>2,
:div_width => 200, :div_height => 150,
:img_width => 200, :img_height => 150,
:style => 'position:relative;float:left;top:0px')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:s_body]).id,
:position_id =>3,
:div_width => 200, :div_height => 150,
:img_width => 200, :img_height => 150,
:style => 'position:relative;float:left;top:0px')