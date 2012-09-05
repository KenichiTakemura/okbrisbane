require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  
  def add_a_post
    job = Job.new(:subject => subject, :category => Job::Categories[:seek], :valid_until => Time.now.utc)
    assert job.save
    job
  end
  
  test "add attachment" do
    post = add_a_post
    assert !post.has_attachment
    assert !post.has_attachment
    attachment = Attachment.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert attachment.save, "Attachment Not Save"
    attachment.attached_to(post)
    assert post.has_attachment
    assert post.has_attachment?
  end
  
  test "delete attachment" do
    post = add_a_post
    assert !post.has_attachment
    assert !post.has_attachment
    attachment = Attachment.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert attachment.save, "Attachment Not Save"
    attachment.attached_to(post)
    assert post.has_attachment
    assert post.has_attachment?
    assert attachment.destroy
    assert !post.has_attachment
    assert !post.has_attachment?
  end

  test "more attachment" do
    post = add_a_post
    attachment1 = Attachment.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert attachment1.save, "Attachment1 Not Save"
    attachment2 = Attachment.new(:avatar => File.new("test/fixtures/images/banner1.jpg"))
    assert attachment2.save, "Attachment2 Not Save"
    attachment1.attached_to(post)
    attachment2.attached_to(post)
    assert post.has_attachment
    assert post.has_attachment?
    assert attachment1.destroy
    assert post.has_attachment
    assert post.has_attachment?
    assert_equal(post.attachment.size, 1)
    assert attachment2.destroy
    assert !post.has_attachment
    assert !post.has_attachment?
  end
  
end
