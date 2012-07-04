# -*- coding: utf-8 -*-
require 'test_helper'

class BuyAndSellTest < ActiveSupport::TestCase

  def setup
    u = User.new(:email => "test@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane")
    assert u.save, "Cannot save user"
    u = User.first
    assert u, "User not found"
  end
  
  def new_post
    bas = BuyAndSell.new(:subject => subject, :category => BuyAndSell::BUY, :price => 10.00)
    assert bas.save
    bas
  end
  
  test "post without category" do
    bas = BuyAndSell.new(:subject => subject)
    assert !bas.save
  end
  
  test "post with BUY" do
    bas = BuyAndSell.new(:subject => subject, :category => BuyAndSell::BUY)
    assert bas.save
  end

  test "post with SELL" do
    bas = BuyAndSell.new(:subject => subject, :category => BuyAndSell::SELL)
    assert bas.save
  end
  
  test "post with invalid category" do
    bas = BuyAndSell.new(:subject => subject, :category => Job::HIRE)
    assert !bas.save
  end

  test "post with price" do
     bas = BuyAndSell.new(:subject => subject, :category => BuyAndSell::BUY, :price => 10.00)
     assert_equal(bas.price,10.00)
  end
  
  test "user post" do
    u = User.first
    bas = new_post
    bas.set_user(u)
    bas1 = new_post
    bas1.set_user(u)
    Rails.logger.info("u.buy_and_sell : #{u.buy_and_sell}")
    assert_equal(u.buy_and_sell.size, 2)
  end
end
