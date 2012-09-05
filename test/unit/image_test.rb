require 'test_helper'

class ImageTest < ActiveSupport::TestCase

  def add_a_post
    job = Job.new(:subject => subject, :category => Job::Categories[:seek], :valid_until => Time.now.utc)
    assert job.save
    job
  end
 
  test "add image" do
    post = add_a_post
    assert !post.has_image
    assert !post.has_image?
    image = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert image.save, "Image Not Save"
    image.attached_to(post)
    assert post.has_image
    assert post.has_image?
  end
  
  test "delete image" do
    post = add_a_post
    assert !post.has_image
    assert !post.has_image?
    image = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    Rails.logger.debug("image: #{image}")
    assert image.save, "Image Not Save"
    image.attached_to(post)
    assert post.has_image
    assert post.has_image?
    assert image.destroy
    assert !post.has_image
    assert !post.has_image?
  end
  
  test "more images" do
    post = add_a_post
    image1 = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert image1.save, "Image1 Not Save"
    image2 = Image.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert image2.save, "Image2 Not Save"
    image1.attached_to(post)
    image2.attached_to(post)
    assert post.has_image
    assert post.has_image?
    assert image1.destroy
    assert post.has_image
    assert post.has_image?
    assert_equal(post.image.size, 1)
    assert image2.destroy
    assert !post.has_image
    assert !post.has_image?
  end

end
