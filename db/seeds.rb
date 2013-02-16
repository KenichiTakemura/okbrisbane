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

contact_mail_to = "contact@okbrisbane.com"

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
ss.local_signin = true
ss.facebook_signin = true
ss.google_signin = true
ss.naver_signin = false
ss.twitter_signin = false
ss.save

# Banner
Style.create_banners
