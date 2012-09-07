class Issue < Post
  
  attr_accessible :version
    
  # pagination
  default_scope :order => 'created_at DESC'
  paginates_per 10

  # override
  def topfeedable?
    false
  end
  
  scope :is_valid, where("status != ?", Okvalue::ISSUE_CLOSED)
  
  before_save :issue_new
  
  def issue_new
    self.status = Okvalue::ISSUE_NEW  
  end
  
  def assigned
    update_attribute(:status, Okvalue::ISSUE_ASSIGNED)
  end

  def on_qa
    update_attribute(:status, Okvalue::ISSUE_ONQA)
  end

  def closed
    update_attribute(:status, Okvalue::ISSUE_CLOSED)
  end
  
  def reopen
    update_attribute(:status, Okvalue::ISSUE_REOPEN)
  end
  
  def status_list
    list = Array.new
    list.push([I18n.t(Okvalue::ISSUE_NEW),Okvalue::ISSUE_NEW])
    list.push([I18n.t(Okvalue::ISSUE_ASSIGNED),Okvalue::ISSUE_ASSIGNED])
    list.push([I18n.t(Okvalue::ISSUE_ONQA),Okvalue::ISSUE_ONQA])
    list.push([I18n.t(Okvalue::ISSUE_CLOSED),Okvalue::ISSUE_CLOSED])
    list.push([I18n.t(Okvalue::ISSUE_REOPEN),Okvalue::ISSUE_REOPEN])
    list
  end
  
  def category_list
    list = Array.new
    list.push([I18n.t(Okvalue::ISSUE_BUG),Okvalue::ISSUE_BUG])
    list.push([I18n.t(Okvalue::ISSUE_FEATURE_REQUEST),Okvalue::ISSUE_FEATURE_REQUEST])
    list.push([I18n.t(Okvalue::ISSUE_IMPROVEMENT),Okvalue::ISSUE_IMPROVEMENT])
    list
  end
  
end
