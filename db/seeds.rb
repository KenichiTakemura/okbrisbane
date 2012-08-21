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
BusinessCategory.delete_all
SystemSetting.delete_all
Role.delete_all
Home.delete_all
MemberManagement.delete_all

# Users
User.create(:email => "kenichi_takemura1976@yahoo.com", :password => 'kenichi123',
 :password_confirmation => 'kenichi123', :first_name => "켄이치", :last_name => "다케무라",
 :is_special => true)
guest = User.new(:email => "okbrisbane_guest@okbrisbane.com", :first_name => "", :last_name => "Guest",
 :is_special => true)
guest.save(:validate => false)
User.create(:email => "mootal@hanmail.net", :password => 'kristaadams1',
 :password_confirmation => 'kristaadams1', :first_name => "Elliott", :last_name => "Joo",
 :is_special => true)


# OKBRISBANE 
ok = BusinessClient.create(:business_name => Okvalue::BUSINESS_CLIENT_OK, :business_abn => "98 152 354 768", :business_address => 'Shop 3 6 Zamia Street Sunny Bank QLD 4109', :business_url => 'http://www.okbrisbane.com', :business_phone => '07-3345-3256', :business_fax => '07-3343-8558', :business_email => 'info@okbrisbane.com', :contact_name => 'Elliott Joo')
ok.build_business_profile(:head => "OKBRISBANE", :body => 'OKBRISBANE rocks!')
ok.save
image = BusinessProfileImage.new(:avatar => File.new("app/assets/images/common/logo.gif"), :is_main => true)
image.attached_to(ok)
image.save

# SystemSetting
ss = SystemSetting.new
ss.post_expiry_length = 30
ss.socialable = false
ss.save

# BusinessCategory
BusinessCategory.create(:en_name => "Accommodation", :display_name => "Accommodation")
BusinessCategory.create(:en_name => "Hotels", :display_name => "Hotels")
BusinessCategory.create(:en_name => "Motels", :display_name => "Motels")
BusinessCategory.create(:en_name => "Adult_Services", :display_name => "Adult Services")
BusinessCategory.create(:en_name => "Pubs_and_Bars", :display_name => "Pubs & Bars")
BusinessCategory.create(:en_name => "Cinema", :display_name => "Cinema")
BusinessCategory.create(:en_name => "Art_Galleries", :display_name => "Art Galleries")
BusinessCategory.create(:en_name => "Car_Mechanic", :display_name => "Car Mechanic")
BusinessCategory.create(:en_name => "Parking", :display_name => "Parking")
BusinessCategory.create(:en_name => "Towing", :display_name => "Towing")
BusinessCategory.create(:en_name => "Child_Care_and_Day_Care", :display_name => "Child Care & Day Care")
BusinessCategory.create(:en_name => "Dry_Cleaning_and_Laundry", :display_name => "Dry Cleaning & Laundry")
BusinessCategory.create(:en_name => "Pest_Control", :display_name => "Pest Control")
BusinessCategory.create(:en_name => "Schools", :display_name => "Schools")
BusinessCategory.create(:en_name => "TAFE", :display_name => "TAFE")
BusinessCategory.create(:en_name => "Universities", :display_name => "Universities")
BusinessCategory.create(:en_name => "Wedding_Planning", :display_name => "Wedding Planning")
BusinessCategory.create(:en_name => "Wedding_Supplies", :display_name => "Wedding Supplies")
BusinessCategory.create(:en_name => "Party_Supplies", :display_name => "Party Supplies")
BusinessCategory.create(:en_name => "ATM", :display_name => "ATM")
BusinessCategory.create(:en_name => "Bookkeeping", :display_name => "Bookkeeping")
BusinessCategory.create(:en_name => "Banks", :display_name => "Banks")
BusinessCategory.create(:en_name => "Supermarket_and_Grocery_Stores", :display_name => "Supermarket & Grocery Stores")
BusinessCategory.create(:en_name => "Bottle_Shops", :display_name => "Bottle Shops")
BusinessCategory.create(:en_name => "Fruits_and_Vegetables", :display_name => "Fruits & Vegetables")
BusinessCategory.create(:en_name => "Consulates_and_Embassies", :display_name => "Consulates & Embassies")
BusinessCategory.create(:en_name => "Courts", :display_name => "Courts")
BusinessCategory.create(:en_name => "Emergency_Services", :display_name => "Emergency Services")
BusinessCategory.create(:en_name => "Beauty_Salons", :display_name => "Beauty Salons")
BusinessCategory.create(:en_name => "Day_Spas", :display_name => "Day Spas")
BusinessCategory.create(:en_name => "Hairdressers", :display_name => "Hairdressers")
BusinessCategory.create(:en_name => "Clothing_Manufacturers", :display_name => "Clothing Manufacturers")
BusinessCategory.create(:en_name => "Footwear_Manufacturers", :display_name => "Footwear Manufacturers")
BusinessCategory.create(:en_name => "Sporting_Goods_Manufacturers", :display_name => "Sporting Goods Manufacturers")
BusinessCategory.create(:en_name => "Couriers", :display_name => "Couriers")
BusinessCategory.create(:en_name => "Internet_Services", :display_name => "Internet Services")
BusinessCategory.create(:en_name => "Telephone_Services", :display_name => "Telephone Services")
BusinessCategory.create(:en_name => "More_Media_and_Communication", :display_name => "More Media & Communication")
BusinessCategory.create(:en_name => "Dentists", :display_name => "Dentists")
BusinessCategory.create(:en_name => "Mobility_Aids", :display_name => "Mobility Aids")
BusinessCategory.create(:en_name => "Doctors", :display_name => "Doctors")
BusinessCategory.create(:en_name => "Pet_Boarding", :display_name => "Pet Boarding")
BusinessCategory.create(:en_name => "Pet_Care", :display_name => "Pet Care")
BusinessCategory.create(:en_name => "Pet_Training", :display_name => "Pet Training")
BusinessCategory.create(:en_name => "Accountants", :display_name => "Accountants")
BusinessCategory.create(:en_name => "Business_Broker", :display_name => "Business Broker")
BusinessCategory.create(:en_name => "Associations_and_Unions", :display_name => "Associations & Unions")
BusinessCategory.create(:en_name => "Churches", :display_name => "Churches")
BusinessCategory.create(:en_name => "Mosques", :display_name => "Mosques")
BusinessCategory.create(:en_name => "Synagogues", :display_name => "Synagogues")
BusinessCategory.create(:en_name => "Cafes", :display_name => "Cafes")
BusinessCategory.create(:en_name => "Restaurants", :display_name => "Restaurants")
BusinessCategory.create(:en_name => "Takeaways", :display_name => "Takeaways")
BusinessCategory.create(:en_name => "Florists", :display_name => "Florists")
BusinessCategory.create(:en_name => "Mobile_Phones_Retailers", :display_name => "Mobile Phones Retailers")
BusinessCategory.create(:en_name => "Shopping_Centres", :display_name => "Shopping Centres")
BusinessCategory.create(:en_name => "Extreme_Sports", :display_name => "Extreme Sports")
BusinessCategory.create(:en_name => "Gyms_and_Fitness_Centres", :display_name => "Gyms & Fitness Centres")
BusinessCategory.create(:en_name => "Surf_School", :display_name => "Surf School")
BusinessCategory.create(:en_name => "Electricians", :display_name => "Electricians")
BusinessCategory.create(:en_name => "Handyman", :display_name => "Handyman")
BusinessCategory.create(:en_name => "Removalists", :display_name => "Removalists")
BusinessCategory.create(:en_name => "Car_Rental", :display_name => "Car Rental")
BusinessCategory.create(:en_name => "Airport_Shuttles", :display_name => "Airport Shuttles")
BusinessCategory.create(:en_name => "Taxis", :display_name => "Taxis")
BusinessCategory.create(:en_name => "Electricity_Supply", :display_name => "Electricity Supply")
BusinessCategory.create(:en_name => "Gas_Supply", :display_name => "Gas Supply")
BusinessCategory.create(:en_name => "Waste_Treatment", :display_name => "Waste Treatment")

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
[:p_job,:p_buy_and_sell,:p_well_being,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation,:p_sponsor,:p_mypage].each do |page|
Banner.create(:page_id => Style.pageid(page),
:section_id => Style.sectionid(:s_body),
  :position_id => 1,
  :div_width => 220, :div_height => 130,
  :img_width => 220, :img_height => 130,
  :style => 'position:relative;float:left;top:0px')
end
[:p_signin,:p_signup,:p_signout, :p_job,:p_buy_and_sell,:p_well_being,:p_study,:p_immig,:p_estate,:p_law,:p_tax,:p_yellowpage,:p_motor_vehicle,:p_business,:p_accommodation,:p_sponsor,:p_mypage].each do |page|
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
[:p_estate,:p_motor_vehicle,:p_business,:p_accommodation,:p_law,:p_tax,:p_study,:p_immig].each do |page|
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
