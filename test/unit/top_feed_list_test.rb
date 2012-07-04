require 'test_helper'

class TopFeedListTest < ActiveSupport::TestCase

  def add_a_post
     job = Job.new(:category => Job::SEEK, :subject => subject)
     assert job.save
     job
   end

  test "feed_a_post" do
    assert_equal(TopFeedList.job_feed.size,0)
    add_a_post
    assert_equal(TopFeedList.job_feed.size,1)
  end
  
  test "feed_max_posts" do
    TopFeedList::TOP_FEED_SAVED_LIMIT.times {
      add_a_post
    }
    assert_equal(TopFeedList.job_feed.size, TopFeedList::TOP_FEED_LIMIT)
  end
  
  test "feed_over_max_posts" do
    first_post = Job.new(:category => Job::SEEK, :subject => 'first')
    assert first_post.save
    TopFeedList::TOP_FEED_SAVED_LIMIT.times {
      add_a_post
    }
    assert_equal(TopFeedList.job_feed.size, TopFeedList::TOP_FEED_LIMIT)
    assert !TopFeedList.find_by_feeded_to_id(first_post), "First Job found"
  end
  
  test "delete old post" do
    first_post = Job.new(:category => Job::SEEK, :subject => 'first')
    assert first_post.save
    TopFeedList::TOP_FEED_SAVED_LIMIT.times {
      add_a_post
    }
    first_post.destroy
    assert_equal(TopFeedList.category_feed("Job").size,TopFeedList::TOP_FEED_SAVED_LIMIT)
  end
  
  test "delete new post" do
    TopFeedList::TOP_FEED_LIMIT.times {
      add_a_post
    }
    first_post = Job.new(:category => Job::SEEK, :subject => 'first')
    assert first_post.save
    first_post.destroy
    assert_equal(TopFeedList.job_feed.size,TopFeedList::TOP_FEED_LIMIT)
  end
  
  test "add many posts" do
    1000.times {
      add_a_post
    }
    assert_equal(TopFeedList.job_feed.size, TopFeedList::TOP_FEED_LIMIT)
    assert_equal(TopFeedList.category_feed("Job").size,TopFeedList::TOP_FEED_SAVED_LIMIT)
  end
  
 end
