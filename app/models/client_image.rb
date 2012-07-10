class ClientImage < Attachable
  attr_accessible :zindex, :business_client_id, :resolution, :link_to_url

  belongs_to :business_client
  
  def to_s
    "business_client_id: #{business_client_id} resolution: #{resolution} link_to_url: #{link_to_url}"
  end
  
end
