class Image < Attachable
  attr_accessible :write_at, :something

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
  validates :avatar, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  
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
