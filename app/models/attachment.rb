class Attachment < Attachable
  
   has_attached_file :avatar, :styles => {},
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
   
  def to_s
    super.to_s
  end

  # https://github.com/thoughtbot/paperclip
  validates :avatar, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :avatar
  validates_attachment_size :avatar, :less_than => 5.megabytes
  #validates_attachment_content_type :avatar, :content_type => ['text/plain', 'application/pdf','application/vnd.oasis.opendocument.presentation'], :message => "unsupported_content_type"
  
  after_initialize :set_default

  def set_default
    self.thumb_size ||= "120x120"
    self.medium_size ||= "400x400"
  end
  
  def url
    self.avatar.url(:original)
  end
  
  def filename
    self.avatar_file_name
  end
  
end
