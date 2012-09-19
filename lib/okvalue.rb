# -*- coding: utf-8 -*-
module Okvalue
  
  #Release History
  #VERSION = "0.1-20120909"
  #VERSION = "0.2-20120910"
  #VERSION = "0.3-20120912"
  #VERSION = "0.3.1-20120913"
  #VERSION = "0.4-20120914"
  #Plan
  #VERSION = "0.5-20120917"
  VERSION = "0.6-20120919"
  #VERSION = "0.7-20120921"
  #VERSION = "0.8-20120923"
  #VERSION = "0.9-20120926"
  #VERSION = "1.0-20120929"

  
  ACCESS_KEY = "Showa"

  COLORMAP = {:ok => "#642c78", :naver => "#41A317", :blue => "#4479BA"}
  
  POST_ADMIN = "post_admin@okbrisbane.com"

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

  TOPFEED_IMAGE_SIZE = "120x100"
  OKBOARD_LIMIT = 50
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

  POST_ABUSE_LIMIT = 2
  POST_RANK_0 = (0..4)
  POST_RANK_1 = (5..10)
  POST_RANK_2 = (11..20)
  POST_RANK_3 = (21..30)
  POST_RANK_4 = (31..40)
  POST_RANK_5 = 41
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

  ATTACHABLE_YES = "attachable_yes"
  ATTACHABLE_NO = "attachable_no"
  
  RATE = "http://community.fxkeb.com/fxportal/jsp/RS/DEPLOY_EXRATE/12776_0.html"
  

  AU = 1
  NZ = 2
  KR = 3
  US = 4
  
  CONTACT_BANNER = 1
  CONTACT_GENERAL = 2
  CONTACT_FEEDBACK = 3
  CONTACT_ISSUE = 4
  CONTACT_EXIT = 5
  
  SITE_STATISTICS_DAILY = "daily"
  SITE_STATISTICS_MONTHLY = "monthly"

  FOOTER_TEXT1 = "okbrisbane.com  All Rights Reserved."
  FOOTER_TEXT2 = "OOK Pty Ltd ABN 98 152 354 768  Add.: Shop 3, 6 Zamia Street Sunnybank QLD 4109 T. 07) 3345-3256 F.07) 3343-8558"


end
