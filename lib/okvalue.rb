# -*- coding: utf-8 -*-
module Okvalue
  
  COLORMAP = {:ok => "#642c78", :naver => "#41A317", :blue => "#4479BA"}
    
  # Global Variables
  
  LOCALE_KO = "ko"
  LOCALE_EN = "en"
  LOCALE_ZHCN = "zh-CN"
  
  MAX_POST_COMMENT_LENGTH = 1000
  MAX_POST_CONTENT_LENGTH = 10000
  MAX_BUSINESS_PROFILE_CONTENT_LENGTH = 10000
  
  MAX_CLIENT_IMAGE_SIZE = 6.megabytes
  
  # DB
  # 1 to 255 bytes: TINYTEXT
  # 256 to 65535 bytes: TEXT
  # 65536 to 16777215 bytes: MEDIUMTEXT
  # 16777216 to 4294967295 bytes: LONGTEXT
  DB_POST_COMMENT_LENGTH = 65535
  DB_POST_CONTENT_LENGTH = 16777215
  DB_BUSINESS_PROFILE_CONTENT_LENGTH = 16777215
  
  FLASH_CONTENT_TYPE = "application/x-shockwave-flash"

  DEFAULT_CATEGORY = 'na'
  DEFAULT_LOCALE = LOCALE_KO
  VALID_DAYS = 30
  
  JOB = "jobs"
  BUY_AND_SELL = "buy_and_sells"
  
  # Sales Management
  ESTATE = "estates"
  BUSINESS = "businesses"
  MOTOR_VEHICLE = "motor_vehicles"
  ACCOMMODATION = "accommodations"
  # Infomation Management
  LAW = "legal_services"
  STUDY = "studies"
  IMMIGRATION = "immigrations"
  TAX = "taxes"

  TOPFEED_IMAGE_SIZE = "120x90"
  OKBOARD_LIMIT = 15
  OKBOARD_IMAGE_FEED_LIMIT = 5
  OKBOARD_IMAGE_SIZE = "138x118"
  OKBOARD_MORE_SIZE = 10
  
  ADMIN_EMAIL = "admin@okbrisbane.com"
  
  BANNER_EFFECT_PAUSE = 2500
  BANNER_FADE_SPEED = 800
  
  NUMBER_OF_LEFT_MENU = 5
end