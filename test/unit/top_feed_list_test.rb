require 'test_helper'

class TopFeedListTest < ActiveSupport::TestCase

  def add_a_post
    post = Job.new(:category => Job::Categories[:seek], :subject => subject, :valid_until => Common.current_time, :write_at => Common.current_time)
    assert post.topfeedable?
    assert post.save
    post
  end

  test "feed_a_job" do
    assert_equal(TopFeedList.feed_nomatter_image(:p_job, TopFeedList::TOP_FEED_LIMIT).size,0)
    post = Job.new(:category => Job::Categories[:seek], :subject => subject, :valid_until => Common.current_time, :write_at => Common.current_time)
    assert post.topfeedable?
    assert post.save
    assert_equal(TopFeedList.feed_nomatter_image(:p_job, TopFeedList::TOP_FEED_LIMIT).size, 1)
  end
  
  test "feed_a_buy_and_sell" do
    assert_equal(TopFeedList.feed_nomatter_image(:p_buy_and_sell, TopFeedList::TOP_FEED_LIMIT).size,0)
    post = BuyAndSell.new(:category => BuyAndSell::Categories[:buy], :subject => subject, :price => "3000.00", :valid_until => Common.current_time, :write_at => Common.current_time)
    assert post.topfeedable?
    assert post.save
    assert_equal(TopFeedList.feed_nomatter_image(:p_buy_and_sell, TopFeedList::TOP_FEED_LIMIT).size,1)
  end

  test "feed_a_well_being" do
    assert_equal(TopFeedList.feed_nomatter_image(:p_well_being, TopFeedList::TOP_FEED_LIMIT).size,0)
    post = WellBeing.new(:category => WellBeing::Categories[:event], :subject => subject, :valid_until => Common.current_time, :write_at => Common.current_time)
    assert post.topfeedable?
    assert post.save
    assert_equal(TopFeedList.feed_nomatter_image(:p_well_being, TopFeedList::TOP_FEED_LIMIT).size,1)
  end
  
  test "feed_an_estate" do
    assert_equal(TopFeedList.feed_nomatter_image(:p_estate, TopFeedList::TOP_FEED_LIMIT).size,0)
    assert_equal(TopFeedList.feed_with_image(:p_estate, TopFeedList::IMAGE_FEED_LIMIT).size,0)
    post = Estate.new(:category => Estate::Categories[:for_rent], :subject => subject, :valid_until => Common.current_time, :price => "3000.00", :write_at => Common.current_time)
    assert post.topfeedable?
    assert post.save
    assert_equal(TopFeedList.feed_nomatter_image(:p_estate, TopFeedList::TOP_FEED_LIMIT).size,1)
    assert_equal(TopFeedList.feed_with_image(:p_estate, TopFeedList::IMAGE_FEED_LIMIT).size,0)
    1.upto(TopFeedList::IMAGE_FEED_LIMIT) { |x|
      post = Estate.new(:category => Estate::Categories[:for_rent], :subject => subject, :valid_until => Common.current_time, :price => "3000.00", :write_at => Common.current_time)
      Image.create(:source_url => "http://test.com").attached_to(post)
      Image.create(:source_url => "http://test.com").attached_to(post)
      Image.create(:source_url => "http://test.com").attached_to(post)
      Image.create(:source_url => "http://test.com").attached_to(post)
      Image.create(:source_url => "http://test.com").attached_to(post)
    }
    assert_equal(TopFeedList.feed_nomatter_image(:p_estate, TopFeedList::TOP_FEED_LIMIT).size,TopFeedList::IMAGE_FEED_LIMIT + 1)
    assert_equal(TopFeedList.feed_with_image(:p_estate, TopFeedList::IMAGE_FEED_LIMIT).size,TopFeedList::IMAGE_FEED_LIMIT)
    ids = TopFeedList.feed_with_image(:p_estate, TopFeedList::IMAGE_FEED_LIMIT).collect {|feed| feed.id }
    assert_equal(TopFeedList.feed_nomatter_image_except(:p_estate, ids, TopFeedList::TOP_FEED_LIMIT).size,1)
     
  end
  
  test "feed_max_posts" do
    TopFeedList::TOP_FEED_SAVED_LIMIT.times {
      add_a_post
    }
    assert_equal(TopFeedList.job_feed.size, TopFeedList::TOP_FEED_LIMIT)
  end

  test "feed_over_max_posts" do
    first_post = Job.new(:category => Job::Categories[:seek], :subject => 'first', :valid_until => Common.current_time)
    assert first_post.save
    TopFeedList::TOP_FEED_SAVED_LIMIT.times {
      add_a_post
    }
    assert_equal(TopFeedList.job_feed.size, TopFeedList::TOP_FEED_LIMIT)
    assert !TopFeedList.find_by_feeded_to_id(first_post), "First Job found"
  end

  test "delete old post" do
    first_post = Job.new(:category => Job::Categories[:seek], :subject => 'first', :valid_until => Common.current_time)
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
    new_post = Job.new(:category => Job::Categories[:seek], :subject => 'new', :valid_until => Common.current_time)
    assert new_post.save, 'Not saved'
    new_post.destroy
    assert_equal(TopFeedList.job_feed.size,TopFeedList::TOP_FEED_LIMIT)
  end

  test "add many posts" do
  (TopFeedList::TOP_FEED_SAVED_LIMIT+1).times {
      add_a_post
    }
    assert_equal(TopFeedList.feed_nomatter_image(:p_job, TopFeedList::TOP_FEED_LIMIT).length, TopFeedList::TOP_FEED_LIMIT)
    assert_equal(TopFeedList.category_feed("Job").length,TopFeedList::TOP_FEED_SAVED_LIMIT)
  end
  
  test "pull feed by size" do
    (TopFeedList::TOP_FEED_SAVED_LIMIT+1).times {
      add_a_post
    }
    assert_equal(TopFeedList.job_feed.size, TopFeedList::TOP_FEED_LIMIT)
    assert_equal(TopFeedList.job_feed_with_limit(5).size, 5)
  end
  
  # Estate
  test "add_same_post" do
    post = Estate.new(:category => Estate::Categories[:for_sale], :subject => 'new', :valid_until => Common.current_time, :price => "AUD 99.99")
    assert post.save, "Not saved"
    post.build_content(:body => body)
    assert post.save, "Not updated"
    assert_equal(TopFeedList.category_feed("Estate").length, 1)
  end

  test "update_post" do
    post = Estate.new(:category => Estate::FOR_SALE, :subject => 'new', :valid_until => Common.current_time, :price => "AUD 99.99")
    assert post.save, "Not saved"
    assert_equal(TopFeedList.estate_feed.size, 1)
    assert_equal(TopFeedList.category_oldest_feed("Estate").first.feeded_to.id, post.id)
    another_post = Estate.new(:category => Estate::FOR_SALE, :subject => 'new', :valid_until => Common.current_time, :price => "AUD 99.99")
    assert another_post.save, "Not saved"
    assert_equal(TopFeedList.category_oldest_feed("Estate").first.feeded_to.id, post.id)
    assert_equal(TopFeedList.estate_feed.size, 2)
    post.build_content(:body => body)
    assert post.save, "Not updated"
    assert_equal(TopFeedList.estate_feed.size, 2)
    assert_equal(TopFeedList.category_oldest_feed("Estate").first.feeded_to.id, another_post.id)
  end
  
  test "hide_a_post" do
    post = Estate.new(:category => Estate::FOR_SALE, :subject => 'new', :valid_until => Common.current_time, :price => "AUD 99.99")
    assert post.save, "Not saved"
    assert_equal(TopFeedList.estate_feed.size, 1)
    post.is_deleted = true
    assert post.save, 'Noy updated'
    assert_equal(TopFeedList.estate_feed.size, 0)
    post.is_deleted = false
    assert post.save, 'Noy updated'
    assert_equal(TopFeedList.estate_feed.size, 1)    
  end
  
  # Accommodation feed
  test "accommodation_feed" do
    post = Accommodation.new(:category => Accommodation::Categories[:hotel], :room_type => Accommodation::ROOM_HOTEL, :subject => 'new', :valid_until => Common.current_time, :price => "AUD 99.99")
    post.build_content(:body => body)
    assert post.save, "Not saved"
    assert_equal(TopFeedList.feed_nomatter_image(:p_accommodation, 5).length, 1)
  end
  
  # Legal Service
  test "legal_service_feed" do
    1.upto(7) do |x|
      post = Law.new(:category => Law::FOR_ACCIDENT, :subject => subject)
      post.build_content
      post.content(:body => body)
      post.valid_until = Time.utc(2012,7,"#{x}")
      assert post.save, "Not saved"
    end
    assert_equal(TopFeedList.legal_service_feed.size, 7)
    assert_equal(TopFeedList.legal_service_feed_with_limit(5).size, 5)
  end
end
