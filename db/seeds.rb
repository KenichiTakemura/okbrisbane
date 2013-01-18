# -*- coding: utf-8 -*-
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Banner.destroy_all
BusinessClient.destroy_all
BusinessProfile.destroy_all
BusinessProfileImage.destroy_all

SystemSetting.destroy_all
Role.destroy_all
Home.destroy_all
MemberManagement.destroy_all

# Users
#User.create(:email => "kenichi_takemura1976@yahoo.com", :password => 'kenichi123',
# :password_confirmation => 'kenichi123', :user_name => "다케무라 켄이치",
# :is_special => true, :confirmed_at => Common.current_time, :agreed_on => Common.current_time, :provider => User::PROVIDERS[:okbrisbane])
#guest = User.new(:email => "okbrisbane_guest@okbrisbane.com", :user_name => "Guest",
# :is_special => true, :confirmed_at => Common.current_time, :agreed_on => Common.current_time, :provider => User::PROVIDERS[:okbrisbane])
#guest.save(:validate => false)


# OKBRISBANE 
ok = BusinessClient.create(:business_name => Okvalue::BUSINESS_CLIENT_OK, :business_abn => "98 152 354 768", :business_address => 'Shop 3 6 Zamia Street Sunny Bank QLD 4109', :business_url => 'http://www.okbrisbane.com', :business_phone => '07-3345-3256', :business_fax => '07-3343-8558', :business_email => 'info@okbrisbane.com', :contact_name => 'Elliott Joo')
ok.build_business_profile(:head => "OKBRISBANE", :body => 'OKBRISBANE rocks!')
ok.save
image = BusinessProfileImage.new(:avatar => File.new("public/images/logo.gif"), :is_main => true)
image.attached_to(ok)
image.save

contact_mail_to = "info@okbrisbane.com"

# SystemSetting
ss = SystemSetting.new
ss.post_expiry_length = 30
ss.socialable = true
ss.issue_report_to = "kenichi_takemura1976@yahoo.com"
ss.admin_email = contact_mail_to
ss.contact_email = contact_mail_to
ss.top_page_ajax = true
ss.banner_clickable = false
ss.banner_ajaxable = true
ss.save

# Banner
Style.create_banners