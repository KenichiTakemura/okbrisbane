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


end
