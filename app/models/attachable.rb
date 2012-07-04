class Attachable < ActiveRecord::Base
  # Make it abstract
  self.abstract_class = true
  
  attr_accessible :is_deleted, :filename, :content_type, :size, :postedOn
  
  belongs_to :attached, :polymorphic => true
  
  belongs_to :attached_by, :polymorphic => true
  
  def attached_to(post, user)
    update_attribute(:attached, post)
    update_attribute(:attached_by, user)
  end
  
end
