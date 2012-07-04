class TopFeedList < ActiveRecord::Base

  TOP_FEED_LIMIT = 10
  TOP_FEED_SAVED_LIMIT = 30

  attr_accessible :category, :post_id

  #validates_inclusion_of :category, :in => ["Job","BuyAndSell"]

  belongs_to :feeded_to, :polymorphic => true

  scope :job_feed, where(:feeded_to_type => 'Job').limit(TOP_FEED_LIMIT)
  
  scope :category_feed, lambda { |cate| where('feeded_to_type = ?', cate)}

  after_save :clean_oldest_feed

  def clean_oldest_feed
    category = self.feeded_to_type
    logger.info("Category: #{category}")
    count = TopFeedList.category_feed(category).count
    logger.info("Count: #{count}")
    return if (count <= TOP_FEED_SAVED_LIMIT)
    logger.debug("Clean oldest feeds")
    oldest_feed = oldest_feed(category)
    TopFeedList.destroy(oldest_feed)
    count = TopFeedList.category_feed(category).count
    logger.info("Count: #{count}")
  end

  protected

  private

  def oldest_feed(category)
    TopFeedList.category_feed(category).limit(1)
  end

end
