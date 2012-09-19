# -*- coding: utf-8 -*-
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  def subject
    subject =  "2012년 브리즈번 한글학교 교사모집합니다. ";
  end

  def body
    body = "2012년 브리즈번 한글학교 교사모집합니다. ";
  end
  
  def body1
    body = "carindale 부근지역 저녁에 은행청소 하실분 모십니다.";
  end
  
  def client
    client = "부근지역 저녁에 은행청소 하실분 모십니다.";
  end
  
  def test_char
    "년"
  end
  
  def contact_name
    contact_name = "부근지역 저녁에 은행청소 하실분 모십니다";
  end
  
  def business_name
    business_name = "부근지역 저녁에 은행청소 하실분 모십니다";
  end
  
  def image_file_name
    image_file_name = "부근지역.png"
  end
  
  def locale
    Okbrisbane::LOCALE_KO  
  end
  
  def emailaddress
    "ok_test_123@gmail.com"
  end
  
  def phonenumber1
    "0433-654-800"    
  end

  def phonenumber2
    "0433654800"    
  end
  
  def phonenumber3
    "0433 654 800"    
  end

  def phonenumber4
    "(07) 3365 4800"    
  end

  def phonenumber5
    "61 (7) 3365 4800"    
  end

  def phonenumber6
    "+61-7 3365 4800"    
  end
end
