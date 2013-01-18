class HotFeedList < ActiveRecord::Base
  belongs_to :hot_feeded_to, :polymorphic => true
  
  MAX_NEW_IMAGES_PER_POST = 3
  HOT_FEED_SAVED_LIMIT = 100
  
  FEED_TYPE = Common.new_orderd_hash
  FEED_TYPE[:p_most_viewed] = {:key => 1, :name => "MostViewed"}
  FEED_TYPE[:p_most_commented] = {:key => 2, :name => "MostCommented"}
  FEED_TYPE[:p_new_images] = {:key => 3, :name => "NewImages"}
  
  def self.what_key?(key)
    FEED_TYPE[key][:key]
  end
  
  #after_save :clean_oldest_feed
  
  def clean_oldest_feed
    hot_key = self.hot_key
    count = HotFeedList.hot_feed_for_all(hot_key).count
    return if (count <= HOT_FEED_SAVED_LIMIT)
    oldest_feed = oldest_feed(hot_key)
    TopFeedList.destroy(oldest_feed)
    count = TopFeedList.category_feed(category).count
  end
  
  scope :feed_order,  order("created_at DESC")
  scope :find_a_feed, lambda { |cate,id| where('hot_feeded_to_type = ? AND hot_feeded_to_id = ?', cate, id)}
  scope :find_a_feed_with_key, lambda { |cate,id,key| where('hot_feeded_to_type = ? AND hot_feeded_to_id = ? AND hot_key = ?', cate, id, key)}
  scope :hot_feed_for_all, lambda { |key| where('hot_key = ?', key).order("hot_value DESC") }
  scope :hot_feed_for, lambda { |key,limit| hot_feed_for_all.limit(limit) }
end
