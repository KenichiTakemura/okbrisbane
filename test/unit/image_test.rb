require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  def add_a_post
    job = Job.new(:subject => subject, :category => Job::Categories[:seek], :valid_until => Time.now.utc)
    assert job.save
    job
  end

  test "add image" do
    post = add_a_post
    assert !post.has_image?
    image = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    image.write_at = Common.current_time.to_i
    assert image.save, "Image Not Save"
    image.attached_to(post)
    assert post.has_image?
  end

  test "delete image" do
    post = add_a_post
    assert !post.has_image
    assert !post.has_image?
    image = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    image.write_at = Common.current_time.to_i
    assert image.save, "Image Not Save"
    image.attached_to(post)
    assert post.has_image?
    assert image.destroy
    assert !post.has_image?
  end

  test "more images" do
    post = add_a_post
    image1 = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    image1.write_at = Common.current_time.to_i
    assert image1.save, "Image1 Not Save"
    image2 = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    image2.write_at = Common.current_time.to_i
    assert image2.save, "Image2 Not Save"
    image1.attached_to(post)
    image2.attached_to(post)
    assert post.has_image?
    assert image1.destroy
    assert post.has_image?
    assert_equal(post.image.count, 1)
    assert image2.destroy
    assert_equal(post.image.count, 0)
    assert !post.has_image?
  end

  test "feed image" do
    post = add_a_post
    assert !post.has_image?
    image = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    image.write_at = Common.current_time.to_i
    assert image.save, "Image Not Save"
    image.attached_to(post)
    post.add_image_to_hot_feed_list
    feed = HotFeedList.hot_feed_for(HotFeedList.what_key?(:p_new_images),1)
    assert_equal feed.length, 1
    assert feed.first.hot_feeded_to.attached_id, post.id
    assert post.has_image?
    assert image.destroy
    feed = HotFeedList.hot_feed_for(HotFeedList.what_key?(:p_new_images),1)
    assert_equal feed.length, 0
    assert !post.has_image?
  end

end
