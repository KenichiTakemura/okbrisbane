# This class represents banner images for a business client and/or a banner space
class ClientImage < Attachable
  attr_accessible :zindex, :business_client_id, :link_to_url, :original_size, :caption, :source_url

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "120x120>" },
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
  
  # many-to-many
  has_many :banner_image
  has_many :banner, :dependent => :destroy, :through => :banner_image

  after_initialize :set_default
  #after_destroy :clean_banner_image
  
  #def clean_banner_image
  #  logger.debug("clean_banner_image: #{self.id}")
  #  records = BannerImage.where("client_image_id = ?", self.id)
  #  records.each do |record|
  #    record.destroy
  #  end
  #end
    
  def set_default
    self.thumb_size ||= "120x120"
    self.medium_size ||= "300x300"
  end

  validates_presence_of :original_size
  # many-to-many
    
  def to_s
    super.to_s + " link_to_url: #{link_to_url} original_size: #{original_size}"
  end
  
end
