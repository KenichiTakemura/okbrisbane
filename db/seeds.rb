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
Page.delete_all
Section.delete_all
BusinessClient.delete_all
BusinessProfile.delete_all
BusinessProfileImage.delete_all
ClientImage.delete_all
Banner.delete_all


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
  :width => 710, :height => 120, :style => 'position:relative;float: left;margin-top:10px;')
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
:width => 320, :height => 200, :style => 'position:absolute;float:right;top:0px;margin-top:0px;right:0px;')
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
# Signin
_page = :signin


# OKBRISBANE 
ok = BusinessClient.create(:business_name => "OKBRISBANE", :business_abn => "", :business_address => 'Shop 3 6 Zamia Street Sunny Bank QLD 4109', :business_url => 'http://www.okbrisbane.com', :business_phone => '07-3343-8880', :business_fax => '07-3343-8558', :business_email => 'mootal@hanmail.net', :contact_name => 'Elliott Joo')
ok.build_business_profile(:body => 'OKBRISBANE rocks!')
ok.save
##### SAMPLE


# Sample Data
# Not for Production
2010.upto(2020) do |x|
  job = Job.new(:category => Job::SEEK, :subject => "#{x}년 北김정은, 공항에 불쑥 나타나 女스튜어디스에 말 걸며");
  job.valid_until = Time.now
  job.save
end
3000.upto(3020) do |x|
  bas = BuyAndSell.new(:category => BuyAndSell::BUY, :subject => "김연아, #{x}년 만에 '록산느의 탱고' 연기한다", :price => 3000.00);
  bas.valid_until = Time.now
  bas.save
end

 
client = BusinessClient.create(:business_name => "AAA Company Pty Ltd.", :business_abn => "12 3456 7890", :business_address => 'Shop123 456 ABC Hills QLD 1234', :business_url => 'http://www.abc.com.au', :business_phone => '07-1234-5678', :business_fax => '07-1234-5678', :business_email => 'abc@abc.com.au', :contact_name => '쉬운일입니다')
client.build_business_profile(:body => 'AAA rocks!')
client.save
client = BusinessClient.create(:business_name => "BBB Company Pty Ltd.", :business_abn => "12 3456 7890", :business_address => 'Shop123 456 ABC Hills QLD 1234', :business_url => 'http://www.abc.com.au', :business_phone => '07-1234-5678', :business_fax => '07-1234-5678', :business_email => 'abc@abc.com.au', :contact_name => '쉬운일입니다')
client.build_business_profile(:body => 'BBB rocks!')
client.save
