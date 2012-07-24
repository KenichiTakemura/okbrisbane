class Post < ActiveRecord::Base

  # Make it abstract
  self.abstract_class = true

  # attr_accessible
  attr_accessible :locale, :category, :subject, :valid_until, :views, :likes, :is_deleted

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
  #validates_presence_of :valid_days, :message => 'Invalid valid_days'
  #validates_numericality_of :valid_days, :only_integer => true, :greater_than => 0, :message => 'Invalid valid_days'
  validates_inclusion_of :locale, :in => [Okvalue::LOCALE_EN,Okvalue::LOCALE_KO,Okvalue::LOCALE_ZHCN], :message => 'Invalid locale'
  #
  def to_s
    "category: #{category} locale: #{locale} subject: #{subject} valid_days: #{valid_days} valid_until: #{valid_until}"
  end
  
  # pagination
  default_scope :order => 'created_at DESC'
  paginates_per 10

  # callbacks
  after_initialize :set_default
  after_validation :set_valid_until
  before_validation :logging_post
  after_save :add_top_feed_list

  # public functions
  def add_top_feed_list
    top_feed = TopFeedList.new
    top_feed.update_attribute(:feeded_to, self)
    top_feed.save
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
    save
  end

end