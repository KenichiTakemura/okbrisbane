class Post < ActiveRecord::Base

  # Make it abstract
  self.abstract_class = true

  # attr_accessible
  attr_accessible :locale, :category, :subject, :valid_until, :views, :likes, :is_deleted

  Categories = Hash.new
  
  def category_list()
    list = Array.new
    Categories.each do |key,value|
      list.push([I18n.t(value),value])
    end
    list
  end
  
  def getCategory(key)
    Categories[key]
  end

  # belongs_to
  belongs_to :posted_by, :polymorphic => true

  # has_many
  has_many :comment, :as => :commented, :dependent => :destroy
  has_many :attachment, :as => :attached, :class_name => 'Attachment', :dependent => :destroy
  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy

  # has_one
  has_one :content, :as => :contented, :dependent => :destroy
  has_one :top_feed_list, :as => :feeded_to, :dependent => :destroy

  # content
  accepts_nested_attributes_for :content
  attr_accessible :content, :content_attributes
  alias_method :content=, :content_attributes=

  # validator
  validates_presence_of :category, :message => I18n.t('must_be_selected')
  validates_presence_of :locale, :message => I18n.t('must_be_selected')
  validates_presence_of :subject, :message => I18n.t('must_be_filled')
  validates_presence_of :valid_until, :message => I18n.t('must_be_filled')
  #validates_presence_of :valid_days, :message => 'Invalid valid_days'
  #validates_numericality_of :valid_days, :only_integer => true, :greater_than => 0, :message => 'Invalid valid_days'
  validates_inclusion_of :locale, :in => [Okvalue::LOCALE_EN,Okvalue::LOCALE_KO,Okvalue::LOCALE_ZHCN], :message => 'Invalid locale'
  #
  def to_s
    "category: #{category} locale: #{locale} subject: #{subject} valid_days: #{valid_days} valid_until: #{valid_until} is_deleted: #{is_deleted}"
  end
  
  # pagination
  default_scope :order => 'updated_at DESC'
  paginates_per 10
  
  scope :is_valid, where("is_deleted != ?", true)
  scope :latest, is_valid.order.limit(Okvalue::OKBOARD_LIMIT)

  
  # callbacks
  after_initialize :set_default
  after_validation :set_valid_until
  before_validation :logging_post
  after_save :add_top_feed_list, :delete_top_feed_list

  # public functions
  def add_top_feed_list
    logger.debug("add_top_feed_list category: #{self}")
    feed = TopFeedList.find_a_feed(self.class.to_s, self.id).first
    logger.debug("Feed: #{feed}")
    if feed
      # Existing in feed
      logger.debug("Feed exists #{feed}")
      feed.destroy
    end
    top_feed = TopFeedList.new
    top_feed.update_attribute(:feeded_to, self)
    logger.debug("Feeded_to: #{top_feed.id}")
   end
   
   def delete_top_feed_list
    return if !self.is_deleted
    logger.debug("delete_from_top_feed_list #{self}")
    feed = TopFeedList.find_a_feed(self.class.to_s, self.id).first
    feed.destroy    
   end

  def set_default
    self.locale ||= Okvalue::DEFAULT_LOCALE
    self.valid_days = Okvalue::VALID_DAYS if self.valid_days == 0
    self.category ||= Okvalue::DEFAULT_CATEGORY
  end

  def set_valid_until
    if !self.valid_until
      self.valid_until = self.valid_days.days.since Time.now
    else
      self.valid_days = 0
    end
  end

  def viewed
    logger.debug("views => " + self.views.to_s)
    self.views = self.views + 1
    self.save
    logger.info("views => " + self.views.to_s)
  end

  def liked
    logger.debug("likes => " + self.likes.to_s)
    self.likes = self.likes + 1
    self.save
    logger.info("likes => " + self.likes.to_s)
  end

  def logging_post
    to_s
  end

  def postedDate
    Common.date_format(created_at)
  end

  def set_user(user)
    update_attribute(:posted_by, user)
  end

end