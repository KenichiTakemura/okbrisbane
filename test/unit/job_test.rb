# -*- coding: utf-8 -*-
require 'test_helper'

class JobTest < ActiveSupport::TestCase
  # Helpers
  def post_not_found(post)
    assert_raise(ActiveRecord::RecordNotFound) {
      Job.find(post)
    }
  end

  def setup
    u = User.new(:email => "test@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane", :user_name => "okbrisbane")
    u.confirmed_at = Time.now.utc
    assert u.save, "Cannot save user"
    u = User.first
    assert u, "User not found"
  end

  def new_post
    job = Job.new(:subject => subject, :category => Job::Categories[:seek], :valid_until => Time.now.utc)
    assert job.save
    job
  end

  test "post without subject" do
    job = Job.new
    assert !job.save
  end

  test "post without category" do
    job = Job.new(:subject => subject)
    assert !job.save
  end

  test "post with SEEK" do
    new_post
  end

  test "post with HIRE" do
    job = Job.new(:subject => subject, :category => Job::Categories[:hire], :valid_until => Time.now.utc)
    assert job.save
  end

  test "post with invalid category" do
    job = Job.new(:subject => subject, :category => BuyAndSell::Categories[:buy], :valid_until => Time.now.utc)
    assert job.save
  end

  test "post check default values"   do
    job = new_post
    assert_equal(job.locale, Okvalue::DEFAULT_LOCALE)
    assert_equal(job.views,0)
    assert_equal(job.likes,0)
    assert_equal(job.dislikes,0)
    assert_equal(job.rank,0)
    assert !job.posted_by, "User allocated"
    assert job.comment.empty?, "Comment allocated"
    assert job.attachment.empty?, "Attachment allocated"
    assert job.image.empty?, "Image allocated"
    assert !job.content, "Content allocated"
    assert job.top_feed_list, "TopFeedList not found"
  end

  test "post with user" do
    u = User.first
    job = new_post
    job.set_user(u)
    assert_equal(job.posted_by.email,'test@test.com')
  end

  test "delete post" do
    job = new_post
    assert Job.find(job), "Post not found"
    assert Job.destroy(job), "Post not deleted"
    post_not_found job
  end

  test "delete user" do
    u = User.first
    job = new_post
    job.set_user(u)
    assert_equal(job.posted_by.email,'test@test.com')
    u.destroy
    post_not_found job
  end

  test "viewed" do
    job = new_post
    job.viewed
    assert_equal(job.views,1)
  end

  test "like" do
    job = new_post
    job.like
    assert_equal(job.likes,1)
  end

  test "dislike" do
    job = new_post
    job.dislike
    assert_equal(job.dislikes,1)
  end

  test "abuse" do
    job = new_post
    job.report_abuse
    assert_equal(job.abuse,1)
  end

  test "user post" do
    u = User.first
    job = new_post
    job.set_user(u)
    job1 = new_post
    job1.set_user(u)
    Rails.logger.info("u.job : #{u.job}")
    assert_equal(u.job.size, 2)
  end

  test "rank" do
    job = new_post
    assert_equal(job.rank,0)
    1.upto(Okvalue::POST_RANK_0.max) {
      job.like
    }
    assert_equal(job.rank,0)
    job.like
    assert_equal(job.rank,1)
    job.dislike
    assert_equal(job.rank,0)    
    (Okvalue::POST_RANK_1.min).upto(Okvalue::POST_RANK_1.max) {
      job.like
    }
    assert_equal(job.rank,1)
    job.like
    assert_equal(job.rank,2)
    job.dislike
    assert_equal(job.rank,1)    
    (Okvalue::POST_RANK_2.min).upto(Okvalue::POST_RANK_2.max) {
      job.like
    }
    assert_equal(job.rank,2)
    job.like
    assert_equal(job.rank,3)
    job.dislike
    assert_equal(job.rank,2)
    (Okvalue::POST_RANK_3.min).upto(Okvalue::POST_RANK_3.max) {
      job.like
    }
    assert_equal(job.rank,3)
    job.like
    assert_equal(job.rank,4)
    job.dislike
    assert_equal(job.rank,3)
    (Okvalue::POST_RANK_4.min).upto(Okvalue::POST_RANK_4.max) {
      job.like
    }
    assert_equal(job.rank,4)
    job.like
    assert_equal(job.rank,5)
    job.dislike
    assert_equal(job.rank,4)
    job.like
    assert_equal(job.rank,5)
    1.upto(10) {
      job.like
    }
    assert_equal(job.rank,5)
    job.report_abuse
    assert_equal(job.rank,5)
    job.report_abuse
    assert_equal(job.rank,0)
  end

end
