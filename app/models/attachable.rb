class Attachable < ActiveRecord::Base
  # Make it abstract
  self.abstract_class = true
  
  attr_accessible :is_deleted, :medium_size, :thumb_size, :attached_id
  
  attr_accessible :avatar
  
  belongs_to :attached, :polymorphic => true
  belongs_to :attached_by, :polymorphic => true

  validates_presence_of :avatar
    
  def attached_to_by(post, user)
    update_attribute(:attached, post)
    update_attribute(:attached_by, user)
  end
  
  def attached_by(user)
   update_attribute(:attached_by, user)
  end
  
  def attached_to(post)
    update_attribute(:attached, post)
  end
  
  def to_s
    "id: #{id} a_file_name: #{avatar_file_name} a_content_type #{avatar_content_type} a_file_size: #{avatar_file_size} attached_id: #{attached_id} attached_type: #{attached_type}"
  end
  
  def thumbnailable?
    return false unless avatar.content_type
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg'].join('').include?(avatar.content_type)
  end

  def flash_thumbnailable?
    return false unless avatar.content_type
    ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg',Okvalue::FLASH_CONTENT_TYPE].join('').include?(avatar.content_type)
  end
  
  def attachmentable?
    return true if thumbnailable?
    return false unless avatar.content_type
    ['text/plain', 'application/pdf','application/vnd.oasis.opendocument.presentation','application/zip','application/msword','application/msexcel','application/rtf','text/rtf','application/x-gzip'].join('').include?(avatar.content_type)
  end
  
  def proc_geo
    file = avatar.queued_for_write[:original].path
    logger.debug("proc_geo file: #{file}")
    geo = Paperclip::Geometry.from_file(file)
    logger.debug("geo: #{geo}")
    self.original_size = geo.to_s
  end
  
#  AttachmentContentTypeValidator
#  AttachmentPresenceValidator
#  AttachmentSizeValidator
#  validates_attachment :avatar, :presence => true,
#  :content_type => { :content_type => "image/jpg" },
#  :size => { :in => 0..10.kilobytes }
  
end
