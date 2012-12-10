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
    avatar.url(:original)
  end

  def medium_image
    avatar.url(:medium)
  end
  
  after_save :mark_main_on_save
  after_destroy :mark_main_on_destroy
  
  def mark_main_on_save
    business_client = BusinessClient.find_by_id(self.attached_id)
    if business_client.business_profile_image.size <= 1 && !self.is_main
      self.is_main = true
      update_attribute(:is_main, true)
    else
      if self.is_main
        business_client.business_profile_image.each do |p|
          next if p.id == self.id
          p.update_attribute(:is_main, false)
        end
      end
    end
  end
  
  def mark_main_on_destroy
    business_client = BusinessClient.find_by_id(self.attached_id)
    return if business_client.business_profile_image.size < 1
    if self.is_main
      business_client.business_profile_image.first.update_attribute(:is_main, true)
    end
  end
  
  
end
