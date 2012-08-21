require 'test_helper'

class BusinessCategoryTest < ActiveSupport::TestCase

  test "add category" do
    category = BusinessCategory.new(:en_name => "123456abcdefABCDEF_", :display_name => subject, :search_keyword => body)
    assert category.save
  end
  
  test "invalid en_name take 1" do
    category = BusinessCategory.new(:en_name => "$!@\#$%^&*()-+=   123456abcdefABCDEF_", :display_name => subject, :search_keyword => body)
    assert !category.save    
  end

  test "invalid en_name take 2" do
    category = BusinessCategory.new(:en_name => subject, :display_name => subject, :search_keyword => body)
    assert !category.save    
  end

  test "uniquness of en_name" do
    category = BusinessCategory.new(:en_name => "123456abcdefABCDEF_", :display_name => subject, :search_keyword => body)
    assert category.save
    category = BusinessCategory.new(:en_name => "123456abcdefABCDEF_", :display_name => body, :search_keyword => body)
    assert !category.save 
  end

  test "uniquness of display_name" do
    category = BusinessCategory.new(:en_name => "123456abcdefABCDEF_", :display_name => subject, :search_keyword => body)
    assert category.save
    category = BusinessCategory.new(:en_name => "123456abcdefABCDEF_Z", :display_name => subject, :search_keyword => body)
    assert !category.save 
  end

end
