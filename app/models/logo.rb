class Logo < Attachable

  has_attached_file :avatar,
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ":rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename"
   
  def to_s
    super.to_s
  end

  MAX_IMAGE_SIZE = 500.kilobytes

  # https://github.com/thoughtbot/paperclip
  validates_attachment_size :avatar, :less_than => MAX_IMAGE_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :original_size, :message => I18n.t('failed_to_create')
  
  #Paperclip callbacks
  after_post_process :proc_geo

  
  def original_image
    self.avatar.url(:original)
  end
  
  def original_path
    self.avatar.path(:original)
  end
  
  def filename
    avatar_file_name
  end
  
  def filesize
    avatar_file_size
  end

end