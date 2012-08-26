class Image < Attachable
  attr_accessible :write_at, :something, :link_to_url, :source_url

  has_attached_file :avatar,
  :styles => lambda { |a|
   if a.instance.thumbnailable?
     { :medium => "400x400>", :thumb => "120x120>" }
   else 
     { }
   end
   },
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
   
  def to_s
    super.to_s + " write_at #{write_at}"
  end

  # https://github.com/thoughtbot/paperclip
  validates_attachment_size :avatar, :less_than => Okvalue::MAX_POST_IMAGE_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :original_size, :message => I18n.t('failed_to_create')
  validates_format_of :link_to_url, :with => URI::regexp(%w(http https)), :message => I18n.t("invalid")
  validates_format_of :source_url, :with => URI::regexp(%w(http https)), :message => I18n.t("invalid")

  #Paperclip callbacks
  after_post_process :proc_geo
  
  after_initialize :set_default

  def set_default
    self.thumb_size ||= "120x120"
    self.medium_size ||= "400x400"
    self.source_url ||= ""
  end

  def width
    "120"
  end

  def height
    "120"
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

end
