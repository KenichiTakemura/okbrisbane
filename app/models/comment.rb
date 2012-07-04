class Comment < ActiveRecord::Base
  attr_accessible :body, :is_deleted, :locale, :postedOn

  belongs_to :commented_by, :polymorphic => true

  belongs_to :commented, :polymorphic => true

  after_initialize :set_default
  
  def set_default
    self.locale ||= ApplicationController::DEFAULT_LOCALE
    self.postedOn ||= Time.now.utc
  end
    
  # validator
  validates_presence_of :body
  validates_length_of :body, :maximum => ApplicationController::MAX_COMMENT_LENGTH

  # Add a comment to a post
  def subscribe_to(post, user)
    self.update_attribute(:commented_by, user)
    self.update_attribute(:commented, post)
    self.save
  end
  

end
