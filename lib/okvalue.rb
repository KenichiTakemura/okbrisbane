# -*- coding: utf-8 -*-
module Okvalue
  
  COLORMAP = {:ok => "#642c78", :naver => "#41A317", :blue => "#4479BA"}
    
  # Global Variables
  
  LOCALE_KO = "ko"
  LOCALE_EN = "en"
  LOCALE_ZHCN = "zh-CN"
  
  MAX_POST_COMMENT_LENGTH = 1000
  MAX_POST_CONTENT_LENGTH = 10000
  MAX_BUSINESS_PROFILE_CONTENT_LENGTH = 50000
  IMAGE_SOMETHING_LENGTH  = 65535
  
  MAX_CLIENT_IMAGE_SIZE = 5.megabytes
  MAX_BUSINESS_PROFILE_IMAGE_SIZE = 5.megabytes
  MAX_POST_IMAGE_SIZE = 5.megabytes
  MAX_POST_ATTACHMENT_SIZE = 5.megabytes
  
  # DB
  # 1 to 255 bytes: TINYTEXT
  # 256 to 65535 bytes: TEXT
  # 65536 to 16777215 bytes: MEDIUMTEXT
  # 16777216 to 4294967295 bytes: LONGTEXT
  DB_POST_COMMENT_LENGTH = 65535
  DB_ISSUE_TEXT_LENGTH = 65535
  DB_POST_CONTENT_LENGTH = 16777215
  DB_BUSINESS_PROFILE_CONTENT_LENGTH = 16777215
  
  FLASH_CONTENT_TYPE = "application/x-shockwave-flash"

  DEFAULT_CATEGORY = 'na'
  DEFAULT_LOCALE = LOCALE_KO
  
  TOPFEED_IMAGE_SIZE = "120x90"
  OKBOARD_LIMIT = 15
  OKBOARD_IMAGE_FEED_LIMIT = 5
  OKBOARD_IMAGE_SIZE = "138x118"
  OKBOARD_MORE_SIZE = 10
  
  BANNER_EFFECT_PAUSE = 2500
  BANNER_FADE_SPEED = 800
  
  NUMBER_OF_LEFT_MENU = 5
  
  ADMIN_POST_Z_INDEX = 10
  ADMIN_POST_NOTICE_Z_INDEX = 20
  ADMIN_POST_NOTICE = "admin_notice"
  
  BUSINESS_CLIENT_OK = "OOK Pty Ltd"
  
  POST_STATUS_DRAFT = "draft"
  POST_STATUS_PUBLIC = "public"
  POST_STATUS_HIDDEN = "hidden"
  POST_STATUS_EXPIRED = "expired"
  
  ISSUE_NEW = "NEW"
  ISSUE_CLOSED = "CLOSED"
  ISSUE_ASSIGNED = "ASSIGNED"
  ISSUE_ONQA = "ON_QA"
  ISSUE_REOPEN = "REOPEN"
  
  ISSUE_BUG = "Bug"
  ISSUE_FEATURE_REQUEST = "Feature_Request"
  ISSUE_IMPROVEMENT = "Improvement"
  
  THUMBNAILABLE = ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']
  FLASH_THUMBNAILABLE = THUMBNAILABLE.clone.push(FLASH_CONTENT_TYPE)
  ATTACHABLE = ['text/plain', 'application/pdf','application/vnd.oasis.opendocument.presentation','application/zip','application/msword','application/msexcel','application/rtf','text/rtf','application/x-gzip']
  
  EMAIL_REGEXP = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  
  DAYS_OPTIONS = [1,2,3,4,5,6,7,8,9,10]
  
  BED_LIST = [1,2,3,4,5]
  BATH_LIST = [0,1,2,3,4,5]
  GARAGE_LIST = [0,1,2,3,4,5]
end