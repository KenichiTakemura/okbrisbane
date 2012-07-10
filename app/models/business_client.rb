class BusinessClient < ActiveRecord::Base
  attr_accessible :business_name, :business_address, :business_abn, :business_url, :business_phone, :business_fax, :business_email, :contact_name
  
  has_many :client_image, :dependent => :destroy
  
  # validator
  validates_presence_of :business_name
  validates_presence_of :contact_name
  
  default_scope :order => 'created_at DESC'
  
  paginates_per 10
  
  def to_s
    "id: #{id} name: #{business_name} abn: #{business_abn} contact_name: #{contact_name} "
  end
    
end
