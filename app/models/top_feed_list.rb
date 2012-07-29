class TopFeedList < ActiveRecord::Base

  TOP_FEED_LIMIT = 10
  IMAGE_FEED_LIMIT = 2
  TOP_FEED_SAVED_LIMIT = 50

  belongs_to :feeded_to, :polymorphic => true
  
  # public scope
  scope :find_a_feed, lambda { |cate,id| where('feeded_to_type = ? AND feeded_to_id = ?', cate, id)}

  scope :feed_order,  order("created_at DESC")
  scope :category_feed, lambda { |cate| where('feeded_to_type = ?', cate)}
  scope :job_feed_with_limit, lambda { |limit| category_feed('Job').feed_order.limit(limit) }
  scope :buy_and_sell_feed_with_limit, lambda { |limit| category_feed('BuyAndSell').feed_order.limit(limit) }
  scope :estate_feed_with_limit, lambda { |limit| category_feed('Estate').feed_order.limit(limit) }
  scope :business_feed_with_limit, lambda { |limit| category_feed('Business').feed_order.limit(limit) }
  scope :motor_vehicle_feed_with_limit, lambda { |limit| category_feed('MotorVehicle').feed_order.limit(limit) }
  scope :accommodation_feed_with_limit, lambda { |limit| category_feed('Accommodation').feed_order.limit(limit) }
  scope :legal_service_feed_with_limit, lambda { |limit| category_feed('Law').feed_order.limit(limit) }
  scope :study_feed_with_limit, lambda { |limit| category_feed('Study').feed_order.limit(limit) }
  
  scope :job_feed, job_feed_with_limit(TOP_FEED_LIMIT)
  scope :buy_and_sell_feed, buy_and_sell_feed_with_limit(TOP_FEED_LIMIT)
  scope :estate_feed, estate_feed_with_limit(TOP_FEED_LIMIT)
  scope :business_feed, business_feed_with_limit(TOP_FEED_LIMIT)
  scope :motor_vehicle_feed, motor_vehicle_feed_with_limit(TOP_FEED_LIMIT)
  scope :accommodation_feed, accommodation_feed_with_limit(TOP_FEED_LIMIT)
  scope :legal_service_feed, legal_service_feed_with_limit(TOP_FEED_LIMIT)
  scope :study_feed, study_feed_with_limit(TOP_FEED_LIMIT)

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

  # private scope

  scope :category_oldest_feed, lambda { |cate| where('feeded_to_type = ?', cate).order("id ASC")}

  def oldest_feed(category)
    TopFeedList.category_oldest_feed(category).first
  end

end
