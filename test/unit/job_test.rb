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
    u = User.new(:email => "test@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane")
    assert u.save, "Cannot save user"
    u = User.first
    assert u, "User not found"
  end

  def new_post
    job = Job.new(:subject => subject, :category => Job::SEEK)
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
    job = Job.new(:subject => subject, :category => Job::HIRE)
    assert job.save
  end

  test "post with invalid category" do
    job = Job.new(:subject => subject, :category => BuyAndSell::BUY)
    assert !job.save
  end

  test "post check default values"   do
    job = new_post
    assert_equal(job.locale, ApplicationController::DEFAULT_LOCALE)
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

  test "post with valid_days"   do
    job = new_post
    assert_equal(job.valid_days, 30)
  end

  test "post with valid_days changed"   do
    job = Job.new(:subject => subject, :category => Job::SEEK)
    job.valid_days = 60;
    assert job.save
    assert_equal(job.valid_days, 60)
    due = 60.days.since job.postedOn
    assert_equal(job.valid_until.strftime("%x"), due.strftime("%x"))
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

  test "liked" do
    job = new_post
    job.liked
    assert_equal(job.likes,1)
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

end
