class Attachable < ActiveRecord::Base
  # Make it abstract
  self.abstract_class = true
  
  attr_accessible :is_deleted, :medium_size, :thumb_size, :attached_id, :original_size
  
  attr_accessible :avatar
  
  belongs_to :attached, :polymorphic => true
  belongs_to :attached_by, :polymorphic => true

  validates_presence_of :avatar
  
  def attached_to_by(post, user)
    attached_to(post)
    update_attribute(:attached_by, user)
  end
  
  def attached_by(user)
   update_attribute(:attached_by, user)
  end
  
  def attached_to(post)
    update_attribute(:attached, post)
    if self.instance_of? Image
      post.set_has_image(true)
    elsif self.instance_of? Attachment
      post.set_has_attachment(true)
    end
  end
  
  after_destroy :post_has_attached
  
  def post_has_attached
    if self.instance_of? Image
      self.attached.set_has_image(false) if self.attached.image.size == 0
    elsif self.instance_of? Attachment
      self.attached.set_has_attachment(false) if self.attached.attachment.size == 0
    end
  end

  def to_s
    "id: #{id} a_file_name: #{avatar_file_name} a_content_type: #{avatar_content_type} a_file_size: #{avatar_file_size} attached_id: #{attached_id} attached_type: #{attached_type} original_size: #{original_size}"
  end
  
  def thumbnailable?
    return false unless avatar.content_type
    Okvalue::THUMBNAILABLE.include?(avatar.content_type)
  end

  def flash_thumbnailable?
    return false unless avatar.content_type
    Okvalue::FLASH_THUMBNAILABLE.include?(avatar.content_type)
  end
  
  def attachmentable?
    return true if thumbnailable?
    return false unless avatar.content_type
    Okvalue::ATTACHABLE.include?(avatar.content_type)
  end
  
  def proc_geo
    file = avatar.queued_for_write[:original].path
    logger.debug("proc_geo file: #{file}")
    geo = Paperclip::Geometry.from_file(file)
    logger.debug("geo: #{geo}")
    self.original_size = geo.to_s
  end
  
end
