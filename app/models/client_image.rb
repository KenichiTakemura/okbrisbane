class ClientImage < Attachable
  attr_accessible :zindex, :business_client_id, :link_to_url

  belongs_to :business_client

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  #after_initialize :set_default
  
  #before_validation :set_size
  
  # This does not work
  def set_size
    avatar.styles[:thumb] = self.thumb_size
    avatar.styles[:medium] = self.medium_size + ">"
    logger.debug("avatar:  #{avatar}")
    logger.debug("avatar.convert_options: #{avatar.convert_options}")
    logger.debug("avatar.styles: #{avatar.styles}")
  end
  # This does not work
  def set_default
    self.thumb_size = "120x120>"
    avatar.styles[:thumb] = self.thumb_size
  end

  def to_s
    "business_client_id: #{business_client_id} medium_size: #{medium_size} link_to_url: #{link_to_url} attached_id: #{attached_id} attached_type: #{attached_type}"
  end

end
