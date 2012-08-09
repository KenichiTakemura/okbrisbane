class Attachable < ActiveRecord::Base
  # Make it abstract
  self.abstract_class = true
  
  attr_accessible :is_deleted, :medium_size, :thumb_size, :accept_content_type, :attached_id
  
  attr_accessible :avatar
  
  belongs_to :attached, :polymorphic => true
  belongs_to :attached_by, :polymorphic => true
  
  def attached_to_by(post, user)
    update_attribute(:attached, post)
    update_attribute(:attached_by, user)
  end
  
  def attached_to(post)
    update_attribute(:attached, post)
  end
  
  def to_s
    "id: #{id} a_file_name: #{avatar_file_name} a_content_type #{avatar_content_type} a_file_size: #{avatar_file_size} attached_id: #{attached_id} attached_type: #{attached_type}"
  end

#  AttachmentContentTypeValidator
#  AttachmentPresenceValidator
#  AttachmentSizeValidator
#  validates_attachment :avatar, :presence => true,
#  :content_type => { :content_type => "image/jpg" },
#  :size => { :in => 0..10.kilobytes }
  
end
