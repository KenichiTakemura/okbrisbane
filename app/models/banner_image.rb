class BannerImage < ActiveRecord::Base
  belongs_to :client_image
  belongs_to :banner
  
  def to_s 
    "client_image: #{client_image_id} banner: #{banner_id}"
  end
end
