require 'test_helper'

class PostSearchTest < ActiveSupport::TestCase

  test "search" do
    post_search = PostSearch.new(:okpage => :p_job)
    assert post_search.save
    assert post_search.okpage
    assert !post_search.has_category?
    assert !post_search.has_keyword?
    assert !post_search.has_image?
    assert !post_search.has_attachment?
    assert !post_search.has_time_by?  
    post_search.category = "category"
    assert post_search.has_category?   
    post_search.keyword = "keyword"
    assert post_search.has_keyword?  
    post_search.image = true
    assert post_search.has_image?
    post_search.attachment = true
    assert post_search.has_attachment?
    post_search.time_by = "time_by"
    assert post_search.has_time_by?   
  end

end
