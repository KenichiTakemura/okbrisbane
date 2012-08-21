# This class represents profile images for a business client
class BusinessProfileImage < Attachable
  attr_accessible :is_main

  has_attached_file :avatar, :styles => { :medium => "500x400>", :thumb => "150x150>" }
  
  def main
    where('is_main = true').first
  end
  
  # https://github.com/thoughtbot/paperclip
  validates :avatar, :attachment_presence => true
  validates_with AttachmentPresenceValidator, :attributes => :avatar
  validates :avatar_content_type, :thumbnailable => true
    
  after_initialize :set_default
    
  def set_default
    self.thumb_size ||= "150x150"
    self.medium_size ||= "500x400"
  end

  def to_s
    super.to_s + " is_main: #{is_main}"
  end
  
end
