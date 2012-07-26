class TopFeedList < ActiveRecord::Base

  TOP_FEED_LIMIT = 10
  TOP_FEED_SAVED_LIMIT = 50

  belongs_to :feeded_to, :polymorphic => true
  
  scope :feed_order,  order("created_at DESC")

  scope :job_feed, where(:feeded_to_type => 'Job').limit(TOP_FEED_LIMIT).feed_order
  scope :buy_and_sell_feed, where(:feeded_to_type => 'BuyAndSell').limit(TOP_FEED_LIMIT).feed_order
  scope :estate_feed, where(:feeded_to_type => 'Estate').limit(TOP_FEED_LIMIT).feed_order
  scope :business_feed, where(:feeded_to_type => 'Business').limit(TOP_FEED_LIMIT).feed_order
  scope :motor_vehicle_feed, where(:feeded_to_type => 'MotorVehicle').limit(TOP_FEED_LIMIT).feed_order
  scope :category_feed, lambda { |cate| where('feeded_to_type = ?', cate)}
  scope :find_a_feed, lambda { |cate,id| where('feeded_to_type = ? AND feeded_to_id = ?', cate, id)}
  scope :category_oldest_feed, lambda { |cate| where('feeded_to_type = ?', cate).order("id ASC")}

  after_save :clean_oldest_feed
  
  def clean_oldest_feed
    category = self.feeded_to_type
    count = TopFeedList.category_feed(category).count
    logger.debug("Category: #{category} Feed Count: #{count}")
    return if (count <= TOP_FEED_SAVED_LIMIT)
    logger.debug("Clean oldest feeds")
    oldest_feed = oldest_feed(category)
    TopFeedList.destroy(oldest_feed)
    count = TopFeedList.category_feed(category).count
    logger.debug("Count: #{count}")
  end
  
  def to_s
    "feeded_to_id: #{feeded_to_id} feeded_to_type: #{feeded_to_type}"
  end

  protected

  private

  def oldest_feed(category)
    TopFeedList.category_oldest_feed(category).first
  end

end
