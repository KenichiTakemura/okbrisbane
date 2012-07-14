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
Alignment.delete_all
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
# Section
Style::ALIGNMENTS.each do |key, value|
  Alignment.create(:name => value)
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
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:header]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:top_left]).id,
:width => 250, :height => 35, :style => '')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:header]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:top_right]).id,
:width => 700, :height => 110, :style => '')
## Background
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:background]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:left]).id,
:width => 150, :height => 600, :style => '')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:background]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:right]).id,
:width => 150, :height => 600, :style => '')
## MainContent
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:main_content]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:top_left]).id,
:width => 600, :height => 400, :style => '')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:main_content]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:top_right]).id,
:width => 300, :height => 200, :style => '')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:main_content]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:left]).id,
:width => 120, :height => 100, :style => '')
## SecondaryContent
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:secondary_content]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:left]).id,
:width => 120, :height => 100, :style => '')

# Signin
_page = :signin
## Header
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:header]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:top_left]).id,
:width => 250, :height => 35, :style => '')
Banner.create(:page_id => Page.find_by_name(Style::PAGES[_page]).id,
:section_id => Section.find_by_name(Style::SECTIONS[:header]).id,
:alignment_id => Alignment.find_by_name(Style::ALIGNMENTS[:top_right]).id,
:width => 700, :height => 110, :style => '')

# OKBRISBANE 
ok = BusinessClient.create(:business_name => "OKBRISBANE", :business_abn => "", :business_address => 'Shop 3 6 Zamia Street Sunny Bank QLD 4109', :business_url => 'http://www.okbrisbane.com', :business_phone => '07-3343-8880', :business_fax => '07-3343-8558', :business_email => 'mootal@hanmail.net', :contact_name => 'Elliott Joo')
ok.build_business_profile(:body => 'OKBRISBANE rocks!')
ok.save
##### SAMPLE


# Data
2010.upto(2020) do |x|
  job = Job.new(:category => Job::SEEK, :subject => "#{x}년 브리즈번 한글학교 교사모집합니다. ");
  job.save
end
3000.upto(3020) do |x|
  bas = BuyAndSell.new(:category => BuyAndSell::BUY, :subject => "#{x}  저녁에 은행청소 하실분 모십니다. ", :price => 3000.00);
  bas.save
end

client = BusinessClient.create(:business_name => "AAA Company Pty Ltd.", :business_abn => "12 3456 7890", :business_address => 'Shop123 456 ABC Hills QLD 1234', :business_url => 'http://www.abc.com.au', :business_phone => '07-1234-5678', :business_fax => '07-1234-5678', :business_email => 'abc@abc.com.au', :contact_name => '쉬운일입니다')
client.build_business_profile(:body => 'AAA rocks!')
client.save
client = BusinessClient.create(:business_name => "BBB Company Pty Ltd.", :business_abn => "12 3456 7890", :business_address => 'Shop123 456 ABC Hills QLD 1234', :business_url => 'http://www.abc.com.au', :business_phone => '07-1234-5678', :business_fax => '07-1234-5678', :business_email => 'abc@abc.com.au', :contact_name => '쉬운일입니다')
client.build_business_profile(:body => 'BBB rocks!')
client.save

#    {category: Job::SEEK, user_id: u.id, subject: '#{x}년 브리즈번 한글학교 교사모집합니다. ', description: '안녕하세요\n\ncarindale 부근지역 저녁에 은행청소 하실분 모십니다.\n\n일은 key job 입니다 저랑 우선은 둘이 3시간정도 합니다 나중에는 혼자서 하셔두 되구요.\n\n은행청소 라 쉬운일입니다,\n\njinyoungkkim@gmail.com 으로 레주메 보내주세요^^\n\n학생분도 환영입니다.'},
