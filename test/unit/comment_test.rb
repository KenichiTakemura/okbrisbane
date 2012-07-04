require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def new_post
    job = Job.new(:subject => subject, :category => Job::SEEK)
    assert job.save
    job
  end
  
  def setup
    post_u = User.new(:email => "post@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane")
    assert post_u.save, "Cannot save user" 
    com_u = User.new(:email => "comment@test.com", :password => "okbrisbane", :password_confirmation => "okbrisbane")
    assert com_u.save, "Cannot save user" 
    post = new_post
    assert post.set_user(post_u)
  end 

  test "add a comment to a post" do
    post = Job.first
    user = User.find_by_email("comment@test.com")
    comment = Comment.new(:body => body)
    assert comment.subscribe_to(post, user)
    assert_equal(post.comment.size,1)
  end
  
  test "add comments to a post" do
    post = Job.first
    comment = Comment.new(:body => body)
    user = User.find_by_email("post@test.com")
    assert comment.subscribe_to(post, user)
    another_comment = Comment.new(:body => body1)
    assert another_comment.subscribe_to(post, user)
    assert_equal(post.comment.size,2)
  end
  
  test "delete comment" do
    post = Job.first
    comment = Comment.new(:body => body)
    user = User.find_by_email("comment@test.com")
    assert comment.subscribe_to(post, user)
    another_comment = Comment.new(:body => body1)
    assert another_comment.subscribe_to(post, user)
    comment.destroy
    assert_equal(post.comment.size,1)
    another_comment.destroy
    assert_equal(post.comment.size,0)
  end
  
  test "delete post" do
    post = Job.first
    comment = Comment.new(:body => body)
    user = User.find_by_email("comment@test.com")
    assert comment.subscribe_to(post, user)
    another_comment = Comment.new(:body => body1)
    assert another_comment.subscribe_to(post, user)
    assert_equal(post.comment.size,2)
    post.destroy
    assert_equal(post.comment.size,0)
    assert_equal(user.comment.size,0)
  end
  
  test "delete user" do
    post = Job.first
    comment = Comment.new(:body => body)
    user = User.find_by_email("comment@test.com")
    assert comment.subscribe_to(post, user)
    another_comment = Comment.new(:body => body1)
    assert another_comment.subscribe_to(post, user)
    assert_equal(post.comment.size,2)
    user.destroy
    assert_equal(post.comment.size,0)
    assert_equal(user.comment.size,0)
  end
end
