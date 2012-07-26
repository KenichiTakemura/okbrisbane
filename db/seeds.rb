# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
TopFeedList.delete_all
Job.delete_all
BuyAndSell.delete_all
Estate.delete_all
Business.delete_all
MotorVehicle.delete_all
Image.delete_all
Page.delete_all
Section.delete_all
BusinessClient.delete_all
BusinessProfile.delete_all
BusinessProfileImage.delete_all
ClientImage.delete_all
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
_page = :home
## Header
Style::PAGES.each do |key, value|
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:header]).id,
  :position_id => 1,
  :width => 500, :height => 60, :style => 'float:right;top:0px;right:10px;position:relative;')
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:header]).id,
  :position_id => 2,
  :width => 710, :height => 120, :style => 'position:relative;float:left;margin-top:10px;')
end
## Background
Style::PAGES.each do |key, value|
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:background]).id,
  :position_id => 1,
  :width => 150, :height => 500, :style => '')
  Banner.create(:page_id => Page.find_by_name(Style::PAGES[key]).id,
  :section_id => Section.find_by_name(Style::SECTIONS[:background]).id,
  :position_id => 2,
  :width => 150, :height => 500, :style => '')
end
## Body
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id =>1,
:width => 650, :height => 380, :style => 'top:0px;float:left;margin:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 2,
:width => 320, :height => 200, :style => 'position:relative;top:0px;margin-top:0px;right:0px;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 3,
:width => 120, :height => 100, :style => 'position:relative;width:650px;height:110px;top:10px;left:0px;float:left;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 4,
:width => 210, :height => 120, :style => 'position:relative;width:650px;height:130px;top:20px;left:0px;float:left;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 5,
:width => 210, :height => 120, :style => 'position:relative;width:650px;height:130px;top:30px;left:0px;float:left;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 6,
:width => 210, :height => 120, :style => 'position:relative;width:650px;height:130px;top:30px;left:0px;float:left;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 7,
:width => 210, :height => 120, :style => 'position:relative;width:650px;height:130px;top:40px;left:0px;float:left;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 8,
:width => 210, :height => 120, :style => 'position:relative;width:650px;height:130px;top:50px;left:0px;float:left;')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:body]).id,
:position_id => 9,
:width => 210, :height => 120, :style => 'position:relative;width:650px;height:130px;top:60px;left:0px;float:left;')
# Signin
_page = :signin


# OKBRISBANE 
ok = BusinessClient.create(:business_name => "OKBRISBANE", :business_abn => "", :business_address => 'Shop 3 6 Zamia Street Sunny Bank QLD 4109', :business_url => 'http://www.okbrisbane.com', :business_phone => '07-3343-8880', :business_fax => '07-3343-8558', :business_email => 'mootal@hanmail.net', :contact_name => 'Elliott Joo')
ok.build_business_profile(:body => 'OKBRISBANE rocks!')
ok.save
