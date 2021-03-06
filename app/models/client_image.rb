# This class represents banner images for a business client and/or a banner space
class ClientImage < Attachable
  attr_accessible :link_to_url, :caption, :source_url

  has_attached_file :avatar,
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename',
   :styles => lambda { |a|
    if a.instance.thumbnailable?
       { :medium => "300x300>", :thumb => "120x120>" }
    else 
       { }
    end
   },
   :processors => lambda { |a|
     if a.thumbnailable?
       [:thumbnail]
     elsif a.flashable?
       [:flash_contents]
     else 
     { }
     end }
  
  # many-to-many
  has_many :banner_image
  has_many :banner, :dependent => :destroy, :through => :banner_image

  after_initialize :set_default
    
  def set_default
    self.thumb_size ||= "120x120"
    self.medium_size ||= "300x300"
    self.link_to_url ||= ""
    self.source_url ||= ""
  end

  validates_attachment_size :avatar, :less_than => Okvalue::MAX_CLIENT_IMAGE_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :original_size, :message => I18n.t('failed_to_create'), :if => Proc.new { |client_image| client_image.source_url.empty? }
  validates_format_of :link_to_url, :with => URI::regexp(%w(http https)), :if => Proc.new { |client_image| !client_image.link_to_url.empty? }
  validates_format_of :source_url, :with => URI::regexp(%w(http https)), :if => Proc.new { |client_image| !client_image.source_url.empty? }
  
  #Paperclip callbacks
  after_post_process :proc_geo
  
  def to_s
    super.to_s + "source_url: #{source_url} link_to_url: #{link_to_url} original_size: #{original_size}"
  end
  
  def thumb_image
    return self.avatar.url(:thumb) if self.source_url.empty?
    self.source_url
  end
  
  def medium_image
    return self.avatar.url(:medium) if self.source_url.empty?
    self.source_url
  end
  
  def original_image
    return self.avatar.url(:original) if self.source_url.empty?
    self.source_url
  end
  
  def flash?
    self.avatar_content_type == Okvalue::FLASH_CONTENT_TYPE
  end
  
  def flash_url
    self.avatar.url(:original).sub(".jpg","")
  end
  
  def flashable?
    return false unless avatar.content_type
    [Okvalue::FLASH_CONTENT_TYPE].include?(avatar.content_type)
  end
  
  def attachable_list
    Okvalue::FLASH_THUMBNAILABLE.collect {|a| "#{a} "}
  end
  
  def linkable?
    if !self.link_to_url.nil? && !self.link_to_url.empty?
      return true
    end
    false
  end
  
  def link
    self.link_to_url
  end
  
  def click
    update_attribute(:clicked, clicked + 1)
    update_attribute(:last_clicked, Common.current_time)
  end
  
end