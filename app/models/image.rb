class Image < Attachable
  attr_accessible :original_size, :write_at, :something

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
    super.to_s
  end

  # https://github.com/thoughtbot/paperclip
  validates_attachment_size :avatar, :less_than => Okvalue::MAX_POST_IMAGE_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :original_size, :message => I18n.t('failed_to_create')

  #Paperclip callbacks
  after_post_process :proc_geo
  
  after_initialize :set_default

  def set_default
    self.thumb_size ||= "120x120"
    self.medium_size ||= "400x400"
  end

  def width
    "120"
  end

  def height
    "120"
  end
  
  def thumb_image
    self.avatar.url(:thumb)
  end
  
  def medium_image
    self.avatar.url(:medium)
  end
  
  def original_image
    self.avatar.url(:original)
  end

end
