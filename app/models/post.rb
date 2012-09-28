class Post < ActiveRecord::Base

  # Make it abstract
  self.abstract_class = true

  # attr_accessible
  attr_accessible :locale, :category, :subject, :valid_until, :views, :likes, :dislikes, :rank, :abuse, :z_index, :write_at, :mode, :comment_email, :has_image, :has_attachment
  
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
  validates_presence_of :subject
  validates_presence_of :valid_until
  validates_presence_of :status
  validates_presence_of :write_at

  validates_numericality_of :views, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :likes, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :dislikes, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :rank, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :abuse, :only_integer => true, :greater_than_or_equal_to => 0
  validates_inclusion_of :locale, :in => [Okvalue::LOCALE_EN,Okvalue::LOCALE_KO,Okvalue::LOCALE_ZHCN], :message => 'Invalid locale'
  #
  def to_s
    "id: #{id} category: #{category} locale: #{locale} subject: #{subject} valid_until: #{valid_until} status #{status}"
  end
  
  # pagination
  #default_scope :order => 'id DESC'
  paginates_per 10
  
  # scope
  scope :asc, :order => 'id ASC'
  scope :desc, :order => 'id DESC'
  scope :is_valid, where("status = ?", Okvalue::POST_STATUS_PUBLIC)
  scope :is_invalid, where("status = ? OR status = ?", Okvalue::POST_STATUS_HIDDEN, Okvalue::POST_STATUS_DRAFT)
  scope :expired, where("status = ?", Okvalue::POST_STATUS_EXPIRED)
  scope :latest, is_valid.desc

  scope :c_category, lambda { |cond|
    if cond.has_category?
      where('category = ?', cond.category)
    end
  }
  scope :c_keyword, lambda { |cond|
    if cond.has_keyword?
      where('subject like ?', "%#{cond.keyword}%")
    end
  }
  scope :c_image, lambda { |cond|
    if cond.has_image?
      where('has_image = ?', cond.image)
    end
  }
  scope :c_attachment, lambda { |cond|
    if cond.has_attachment?
      where('has_attachment = ?', cond.attachment)
    end
  }
  scope :c_time, lambda { |cond|
    if cond.has_time_by?
      case cond.time_by.to_sym
      when :time_by_day_0
        post_search_by_time(0,1)
      when :time_by_day_1
        post_search_by_time(1,2)
      when :time_by_day_2
        post_search_by_time(2,3)
      when :time_by_day_3
        post_search_by_time(3,4)
      when :time_by_day_4
        post_search_by_time(4,5)
      when :time_by_day_5
        post_search_by_time(5,6)
      when :time_by_day_6
        post_search_by_time(6,7)
      when :time_by_week_1
        post_search_by_time(7,8)
      when :time_by_week_2
        post_search_by_time(8,15)
      when :time_by_week_3
        post_search_by_time(15,22)
      when :time_by_week_4
        post_search_by_time(22,29)
      when :time_by_older
        post_search_by_time(29,-1)
      end
    end
  }
  scope :post_search_by_time, lambda { |x,y| 
    if y.to_i > 0
      where("created_at <=? and created_at > ?", (Common.days_ago(x)), (Common.days_ago(y)))
    else
      where("created_at <=?", (Common.days_ago(x)))
    end
  }
  
  scope :except_ids, lambda { |ids| 
    if !ids.nil? && !ids.empty?  
      where('id not in (?)', ids)
    end
  }
  scope :after_id, lambda { |post_id| 
    if post_id.present? 
      where('id > ?', post_id)
    end
  }
  scope :before_id, lambda { |post_id| 
    if post_id.present? 
      where('id < ?', post_id)
    end
  }
  scope :user_post, lambda { |user|
    if user.present?
      where('posted_by_id = ?', user.id).is_valid.desc
    end
  }
  
  scope :search_no_order, lambda { |cond,limit| c_category(cond).c_keyword(cond).c_image(cond).c_attachment(cond).c_time(cond).is_valid.limit(limit)}
  scope :search, lambda { |cond,limit| search_no_order(cond,limit).desc }
  scope :search_except, lambda { |cond,ids,limit| search_no_order(cond,limit).except_ids(ids).desc }
  scope :search_after, lambda { |cond,post_id,limit| search_no_order(cond,limit).after_id(post_id).asc }
  scope :search_before, lambda { |cond,post_id,limit| search_no_order(cond,limit).before_id(post_id).desc }
    
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
    self.comment_email ||= false
    self.write_at ||= Common.current_time.to_i
  end
  
  def viewed
    update_attribute(:views, views + 1)
  end

  def like
    update_attribute(:likes, likes + 1)
    update_attribute(:rank, mark_rank)
  end
  
  def dislike
    update_attribute(:dislikes, dislikes + 1)
    update_attribute(:rank, mark_rank)
  end
    
  def report_abuse
    update_attribute(:abuse, abuse + 1)
    update_attribute(:rank, mark_rank)
  end
  
  def mark_rank
    if abuse >= Okvalue::POST_ABUSE_LIMIT
      return 0
    end
    if (likes - dislikes) < 0
      return 0
    end
    case (likes - dislikes)
    when Okvalue::POST_RANK_0
      return 0
    when Okvalue::POST_RANK_1
      return 1
    when Okvalue::POST_RANK_2
      return 2
    when Okvalue::POST_RANK_3
      return 3
    when Okvalue::POST_RANK_4
      return 4
    else
      return 5
    end
  end

  def logging_post
    to_s
  end

  def postedDate
    Common.date_format(created_at)
  end
  
  # This is used for smaller space
  def feeded_date
    Common.date_format_md(created_at)
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
  
  def set_has_image(yesno)
    update_attribute(:has_image, yesno)
  end

  def set_has_attachment(yesno)
    update_attribute(:has_attachment, yesno)
  end
    
  def has_image?
    #!self.image.empty?
    has_image
  end
      
  def has_attachment?
    #!self.attachment.empty?
    has_attachment
  end
  
  def admin_category_list
    list = category_list.dup
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
  
  def yesno_list
    list = Array.new
    list.push([I18n.t(Okvalue::ATTACHABLE_YES),true])
    list.push([I18n.t(Okvalue::ATTACHABLE_NO),false])
  end
  
  def image_feed_for
    return if image.empty?
    image.each do |i|
      return i if i.linkable? && i.somethingable?
    end
    image.each do |i|
      return i if i.linkable?
    end
    image.first
  end
  
  protected
  
  def topfeedable?
    false
  end

end
