class Post < ActiveRecord::Base

  # Make it abstract
  self.abstract_class = true

  # attr_accessible
  attr_accessible :locale, :category, :subject, :valid_until, :views, :likes, :dislikes, :rank, :abuse, :z_index, :write_at, :mode
  
  # status
  # draft -> public -> hidden -> deleted
  attr_accessible :status
  
  # belongs_to
  belongs_to :posted_by, :polymorphic => true
  belongs_to :post_updated_by, :polymorphic => true

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

  attr_accessible :attached
  
  accepts_nested_attributes_for :attachment
  attr_accessible :attachment, :attachment_attributes
  alias_method :attachment=, :attachment_attributes=

  # validator
  validates_presence_of :category, :message => I18n.t('must_be_selected')
  validates_presence_of :locale, :message => I18n.t('must_be_selected')
  validates_presence_of :subject, :message => I18n.t('must_be_filled')
  validates_presence_of :valid_until, :message => I18n.t('must_be_filled')
  validates_presence_of :status, :message => I18n.t('must_be_filled')
  validates_numericality_of :views, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :likes, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :dislikes, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :rank, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :abuse, :only_integer => true, :greater_than_or_equal_to => 0
  validates_inclusion_of :locale, :in => [Okvalue::LOCALE_EN,Okvalue::LOCALE_KO,Okvalue::LOCALE_ZHCN], :message => 'Invalid locale'
  #
  def to_s
    "category: #{category} locale: #{locale} subject: #{subject} valid_until: #{valid_until} status #{status}"
  end
  
  # pagination
  default_scope :order => 'id DESC'
  paginates_per 10
  
  # scope
  scope :is_valid, where("status = ?", Okvalue::POST_STATUS_PUBLIC)
  scope :is_invalid, where("status = ? OR status = ?", Okvalue::POST_STATUS_HIDDEN, Okvalue::POST_STATUS_DRAFT)
  scope :expired, where("status = ?", Okvalue::POST_STATUS_EXPIRED)
  scope :latest, is_valid.order.limit(Okvalue::OKBOARD_LIMIT)
  scope :category_latest, lambda { |cate| where('category = ?', cate).latest}

  # callbacks
  after_initialize :set_default
  before_validation :logging_post
  after_save :add_top_feed_list, :delete_top_feed_list

  # public functions
  def add_top_feed_list
    logger.debug("add_top_feed_list topfeedable: #{self.topfeedable?}")
    return unless topfeedable?
    logger.debug("category: #{self}")
    return if self.category.eql?(Okvalue::ADMIN_POST_NOTICE)
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
   
   # Delete post from top_feed when deleted
   def delete_top_feed_list
    return unless topfeedable?
    if !self.status.eql?(Okvalue::POST_STATUS_PUBLIC)
      logger.debug("delete_from_top_feed_list #{self}")
      feed = TopFeedList.find_a_feed(self.class.to_s, self.id).first
      feed.destroy if feed
    end
   end

  def set_default
    self.locale ||= Okvalue::DEFAULT_LOCALE
    self.category ||= Okvalue::DEFAULT_CATEGORY
    self.z_index ||= 0
    self.status ||= Okvalue::POST_STATUS_PUBLIC
    self.mode ||= Role::R[:user_r] | Role::R[:user_w]
  end
  
  def viewed
    self.update_attribute(:views, self.views + 1)
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

  def validDate
    Common.date_format(valid_until)
  end

  def set_user(user)
    update_attribute(:posted_by, user)
    user.mypage.add_post
  end
  
  def updated_by(user)
    update_attribute(:post_updated_by, user)
  end
  
  def has_image?
    !self.image.empty?
  end
      
  def has_attachment?
    !self.attachment.empty?
  end
  
  def admin_category_list
    list = category_list.clone
    #list = Array.new
    list.push([I18n.t(Okvalue::ADMIN_POST_NOTICE),Okvalue::ADMIN_POST_NOTICE])
    list
  end
  
  def status_list
    list = Array.new
    list.push([I18n.t(Okvalue::POST_STATUS_DRAFT),Okvalue::POST_STATUS_DRAFT])
    list.push([I18n.t(Okvalue::POST_STATUS_PUBLIC),Okvalue::POST_STATUS_PUBLIC])
    list.push([I18n.t(Okvalue::POST_STATUS_HIDDEN),Okvalue::POST_STATUS_HIDDEN])
    list
  end
  
  protected
  
  def topfeedable?
    false
  end

end
