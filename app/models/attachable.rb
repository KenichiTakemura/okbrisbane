class Attachable < ActiveRecord::Base
  # Make it abstract
  self.abstract_class = true
  
  attr_accessible :is_deleted, :medium_size, :thumb_size, :attached_id, :original_size, :device
  
  attr_accessible :avatar
  
  belongs_to :attached, :polymorphic => true
  belongs_to :attached_by, :polymorphic => true

  validates_presence_of :avatar
  
  def attached_to_by(post, user)
    attached_to(post)
    update_attribute(:attached_by, user)
  end
  
  def attached_by_user(user)
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
  
  before_destroy :save_attached_post
  
  def save_attached_post
    @@post = self.attached
  end
  
  after_destroy :post_has_attached
  
  def post_has_attached
    @@post = self.attached
    # This indicates attached is not saved yet.
    return if @@post.nil?
    if self.instance_of? Image
      @@post.set_has_image(false) if @@post.image.count == 0
    elsif self.instance_of? Attachment
      @@post.set_has_attachment(false) if @@post.attachment.count == 0
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

  def filename
    avatar_file_name
  end
  
  def filesize
    avatar_file_size
  end
  
  def author
    if attached_by.present?
      return attached_by.name
    end
    t("unknown_user")
  end
  
  def device_list
    [[Webcom::Browser::DEVISE_PC,I18n.t("pc")],
      [Webcom::Browser::DEVISE_PHONE,I18n.t("phone")],
      [Webcom::Browser::DEVISE_TABLET,I18n.t("tablet")]]
  end
  
  THUMBNAILABLE = %w{jpeg, pjpeg, gif, png, x-png, jpg}

end
