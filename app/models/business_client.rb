class BusinessClient < ActiveRecord::Base
  attr_accessible :business_name
  attr_accessible :business_address
  attr_accessible :business_abn
  attr_accessible :business_url
  attr_accessible :business_phone
  attr_accessible :business_fax
  attr_accessible :business_email
  attr_accessible :contact_name

  has_many :client_image, :dependent => :destroy
  has_many :business_profile_image, :as => :attached, :dependent => :destroy
  has_one :business_profile, :dependent => :destroy
  
  belongs_to :business_category
  
  accepts_nested_attributes_for :business_profile, :allow_destroy => true
  attr_accessible :business_profile, :business_profile_attributes
  alias_method :business_profile=, :business_profile_attributes=

  # validator
  validates_presence_of :business_name
  validates_presence_of :contact_name
  validates_uniqueness_of :business_name

  # pagination
  default_scope :order => 'created_at DESC'
  paginates_per 10
  
  scope :okbrisbane, where(:business_name => 'OKBRISBANE')
  
  def to_s
    "id: #{id} name: #{business_name} abn: #{business_abn} contact_name: #{contact_name} profile: #{business_profile} client_image: #{client_image} profile_image: #{business_profile_image}"
  end

  def set_profile(body)
    self.build_business_profile(:body => body)
  end
  
  def main_profile_image
    self.business_profile_image.each do |profile_image|
       return profile_image if profile_image.is_main
    end
  end

end
