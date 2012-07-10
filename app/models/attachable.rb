class Attachable < ActiveRecord::Base
  # Make it abstract
  self.abstract_class = true
  
  attr_accessible :is_deleted, :avatar
  
  belongs_to :attached, :polymorphic => true
  
  belongs_to :attached_by, :polymorphic => true
  
  def attached_to(post, user)
    update_attribute(:attached, post)
    update_attribute(:attached_by, user)
  end
  
  # https://github.com/thoughtbot/paperclip

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  validates :avatar, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :avatar

#  AttachmentContentTypeValidator
#  AttachmentPresenceValidator
#  AttachmentSizeValidator
#  validates_attachment :avatar, :presence => true,
#  :content_type => { :content_type => "image/jpg" },
#  :size => { :in => 0..10.kilobytes }
  
end
