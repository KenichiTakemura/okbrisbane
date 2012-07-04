class Post < ActiveRecord::Base

  # Make it abstract
  self.abstract_class = true

  # attr_accessible
  attr_accessible :locale, :category, :postedOn, :subject, :valid_until, :views, :likes, :is_deleted

  # belongs_to
  belongs_to :posted_by, :polymorphic => true

  # has_many
  has_many :comment, :as => :commented, :dependent => :destroy
  has_many :attachment, :as => :attached, :class_name => 'Attachment', :dependent => :destroy
  has_many :image, :as  => :attached, :class_name => 'Image', :dependent => :destroy

  # has_one
  has_one :content, :as => :contented, :dependent => :destroy
  has_one :top_feed_list, :as => :feeded_to, :dependent => :destroy

  # validator
  validates_presence_of :category, :locale, :postedOn, :subject, :valid_days, :message => 'Invalid number of parameters'
  validates_numericality_of :valid_days, :only_integer => true, :greater_than => 0, :message => 'Invalid valid_days'
  validates_inclusion_of :locale, :in => [ApplicationController::LOCALE_EN,ApplicationController::LOCALE_KO,ApplicationController::LOCALE_ZHCN], :message => 'Invalid locale'
  #
  def to_s
    #"type: #{type} category: #{category} locale: #{locale} subject: #{subject} postedOn: #{postedOn} valid_days: #{valid_days} valid_until: #{valid_until}"
    "category: #{category} locale: #{locale} subject: #{subject} postedOn: #{postedOn} valid_days: #{valid_days} valid_until: #{valid_until}"

  end

  # callbacks
  after_initialize :set_default
  after_validation :set_valid_until
  before_validation :logging_post
  after_save :add_top_feed_list

  # public functions
  def add_top_feed_list
    top_feed = TopFeedList.new
    #top_feed.update_attribute(:category, self)
    top_feed.update_attribute(:feeded_to, self)
    top_feed.save
  end

  def set_default
    self.locale ||= ApplicationController::DEFAULT_LOCALE
    self.postedOn ||= Time.now.utc
    self.valid_days = ApplicationController::VALID_DAYS if self.valid_days == 0
    self.category ||= ApplicationController::DEFAULT_CATEGORY
  end

  def set_valid_until
    self.valid_until = self.valid_days.days.since self.postedOn
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

  def set_user(user)
    update_attribute(:posted_by, user)
    save
  end

end