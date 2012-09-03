class Comment < ActiveRecord::Base
  attr_accessible :body, :is_deleted, :locale, :likes, :dislikes, :abuse

  belongs_to :commented_by, :polymorphic => true

  belongs_to :commented, :polymorphic => true

  after_initialize :set_default
  
  def set_default
    self.locale ||= Okvalue::DEFAULT_LOCALE
  end
    
  # validator
  validates_presence_of :body
  validates_length_of :body, :maximum => Okvalue::MAX_POST_COMMENT_LENGTH

  # Add a comment to a post
  def subscribe_to(post, user)
    self.update_attribute(:commented_by, user)
    self.update_attribute(:commented, post)
  end

  def postedDate
    Common.date_format(created_at)
  end
  
  def like
    update_attribute(:likes, likes + 1)
  end
  
  def dislike
    update_attribute(:dislikes, dislikes + 1)
  end
    
  def report_abuse
    update_attribute(:abuse, abuse + 1)
  end
  
end
