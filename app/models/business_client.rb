class BusinessClient < ActiveRecord::Base
  attr_accessible :business_name
  attr_accessible :business_address
  attr_accessible :business_abn
  attr_accessible :business_url
  attr_accessible :business_phone
  attr_accessible :business_fax
  attr_accessible :business_email
  attr_accessible :contact_name
  attr_accessible :business_category
  attr_accessible :search_keyword

  has_many :client_image, :as => :attached, :dependent => :destroy, :class_name => 'ClientImage'
  has_many :business_profile_image, :as => :attached, :dependent => :destroy, :class_name => 'BusinessProfileImage'
  has_one :business_profile, :dependent => :destroy
  has_many :logo, :as => :attached, :dependent => :destroy, :class_name => 'Logo'

  belongs_to :business_category

  accepts_nested_attributes_for :business_profile, :allow_destroy => true
  attr_accessible :business_profile, :business_profile_attributes
  alias_method :business_profile=, :business_profile_attributes=

  accepts_nested_attributes_for :logo
  attr_accessible :logo, :logo_attributes
  alias_method :logo=, :logo_attributes=

  # validator
  validates_presence_of :business_name
  #validates_presence_of :contact_name
  validates_uniqueness_of :business_name
  #validates_uniqueness_of :business_abn
  #validates_uniqueness_of :business_url

  # callbacks

  # pagination
  default_scope :order => 'id DESC'
  paginates_per 50

  scope :okbrisbane, where(:business_name => Okvalue::BUSINESS_CLIENT_OK)
  #scope :only_not_selected_image, lambda { ||
  #  joins("left outer join client_images on client_images.id = business_client.attached_to_id").where("client_images.banner = true") }
  scope :match_size, lambda { |size|
    joins("left outer join client_images on client_images.id = business_client.attached_to_id").where("client_images.original_size = ?", size)
  }

  scope :query_by_name, lambda { |name,limit|
    select("business_name").search(name,limit)
  }

  scope :search, lambda { |name,limit|
    where("business_name like ?", "%#{name}%").limit(limit)
  }

  def to_s
    "id: #{id} name: #{business_name} abn: #{business_abn} contact_name: #{contact_name} profile: #{business_profile} client_image: #{client_image} profile_image: #{business_profile_image}"
  end

  def set_profile(head, body)
    self.build_business_profile(:head => head, :body => body)
  end

  def main_profile_image
    self.business_profile_image.each do |profile_image|
      return profile_image if profile_image.is_main
    end
  end

  def has_url?
    self.business_url.present?
  end

  def logo_for(device)
    if self.logo.present?
      self.logo.select {
      |l| l.device == device
      }.first
    end
  end
  
  def self.okbrisbane?
    BusinessClient.okbrisbane.first
  end

  scope :with_banner, joins(:client_image).find(:all, :select => 'distinct business_clients.id')

end
