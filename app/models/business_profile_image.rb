# This class represents profile images for a business client
class BusinessProfileImage < Attachable
  attr_accessible :is_main

  has_attached_file :avatar,
  :styles => lambda { |a|
   if a.instance.thumbnailable?
     { :medium => "400x400>", :thumb => "150x150>" }
   else 
     { }
   end
   },
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
   
  # https://github.com/thoughtbot/paperclip
  #validates :avatar, :attachment_presence => true
  validates_attachment_size :avatar, :less_than => Okvalue::MAX_BUSINESS_PROFILE_IMAGE_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :original_size, :message => I18n.t('failed_to_create')

  after_initialize :set_default
  #Paperclip callbacks
  after_post_process :proc_geo

  def set_default
    self.thumb_size ||= "150x150"
    self.medium_size ||= "400x400"
  end

  def to_s
    super.to_s + " is_main: #{is_main}"
  end

  def original_image
    return self.avatar.url(:original)
  end
  
end
