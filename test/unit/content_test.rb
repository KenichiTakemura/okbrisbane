# -*- coding: utf-8 -*-
require 'test_helper'

class ContentTest < ActiveSupport::TestCase
 
   def build_job_with_content
    job = Job.new(:subject => subject, :category => Job::SEEK)
    job.build_content(:body => body)
    assert job.save
    job
  end
  
  def content_not_found(content)
    assert_raise(ActiveRecord::RecordNotFound) {
      Content.find(content)
    }
  end
  
  test "no content" do
    c = Content.new
    assert !c.save
  end

  test "with content" do
    c = Content.new(:body => body)
    assert c.save
  end

  test "minimum content" do
    c = Content.new(:body => 'a')
    assert c.save
  end

  test "maximum content" do
    c = Content.new
    body = String.new
    ApplicationController::MAX_POST_CONTENT_LENGTH.times {
      body << test_char
    }
    Rails.logger.info("body : " + body)
    c.body = body
    assert c.save
  end

  test "over maximum content" do
    c = Content.new
    body = String.new
    ApplicationController::MAX_POST_CONTENT_LENGTH.times {
      body << test_char
    }
    body << test_char
    Rails.logger.info("body : " + body)
    c.body = body
    assert !c.save, "content too long"
  end

  test "job with content" do
    job = build_job_with_content
    assert_equal(job.content.body, body)
  end

  test "job modify content" do
    build_job_with_content
    job1 = Job.first
    job1.content.update_attribute(:body, body1)
    assert job1.save
    assert_equal(job1.content.body, body1)
  end

  test "delete job with content" do
    job = build_job_with_content
    assert Job.find(job), "Job not found"
    assert Content.find(job.content.id), "Content not found"
    assert Job.destroy(job), "Job not deleted"
    content_not_found(job.content.id)
  end

end
