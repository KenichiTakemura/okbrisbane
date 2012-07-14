class BusinessProfileImage < Attachable
  attr_accessible :business_client_id

  belongs_to :business_client

  has_attached_file :avatar, :styles => { :medium => "500x400>", :thumb => "150x150>" }
  
  after_initialize :set_default
    
  def set_default
    self.thumb_size ||= "150x150>"
    self.medium_size ||= "500x400>"
  end

  def to_s
    super.to_s + " business_client_id: #{business_client_id}"
  end

end
