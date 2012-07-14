class ClientImage < Attachable
  attr_accessible :zindex, :business_client_id, :link_to_url

  belongs_to :business_client

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "120x120>" }

  after_initialize :set_default
    
  def set_default
    self.thumb_size ||= "120x120>"
    self.medium_size ||= "300x300>"
  end


  #before_validation :set_size
  
  # This does not work
  def set_size
    avatar.styles[:thumb] = self.thumb_size
    avatar.styles[:medium] = self.medium_size + ">"
    logger.debug("avatar:  #{avatar}")
    logger.debug("avatar.convert_options: #{avatar.convert_options}")
    logger.debug("avatar.styles: #{avatar.styles}")
  end


  def to_s
    super.to_s + " business_client_id: #{business_client_id} link_to_url: #{link_to_url}"
  end
  
end
