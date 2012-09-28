class AdminNotice < ActiveRecord::Base
  attr_accessible :subject, :status
  
  validates_presence_of :subject

  has_one :content, :as => :contented, :dependent => :destroy
  belongs_to :posted_by, :polymorphic => true
    
  default_scope :order => 'id DESC'
  
  scope :current_notice, where(:status => Okvalue::POST_STATUS_PUBLIC).order
  scope :notice_history, where('status = ? OR status = ?', Okvalue::POST_STATUS_PUBLIC, Okvalue::POST_STATUS_COMPLETED).order
  
  # content
  accepts_nested_attributes_for :content
  attr_accessible :content, :content_attributes
  alias_method :content=, :content_attributes=

  after_initialize :set_default
  
  def set_default
    self.status ||= Okvalue::POST_STATUS_PUBLIC
  end

  def set_user(user)
    update_attribute(:posted_by, user)
  end
  
  def status_list
    list = Array.new
    list.push([I18n.t(Okvalue::POST_STATUS_DRAFT),Okvalue::POST_STATUS_DRAFT])
    list.push([I18n.t(Okvalue::POST_STATUS_PUBLIC),Okvalue::POST_STATUS_PUBLIC])
    list.push([I18n.t(Okvalue::POST_STATUS_HIDDEN),Okvalue::POST_STATUS_HIDDEN])
    list.push([I18n.t(Okvalue::POST_STATUS_COMPLETED),Okvalue::POST_STATUS_COMPLETED])
    list
  end
  
  def postedDate
    Common.date_format(created_at)
  end
end
