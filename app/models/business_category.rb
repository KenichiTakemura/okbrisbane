class BusinessCategory < ActiveRecord::Base
  attr_accessible :en_name, :display_name  
  attr_accessible :search_keyword

  has_many :business_client
  
  # validator
  validates_presence_of :en_name
  validates_presence_of :display_name
  validates_uniqueness_of :en_name
  validates_uniqueness_of :display_name
  validates :en_name, :format => { :with => /^[\w]*$/ }

  # pagination
  default_scope :order => 'business_categories.id ASC'
  paginates_per 100
  
  scope :with_client, joins(:business_client).select("business_categories.display_name, business_categories.id").group("business_categories.display_name")
  
  scope :query_by_name, lambda { |name,limit|
    select("display_name").search(name,limit)
  }
  
  scope :search, lambda { |name,limit|
    where("display_name like ?", "#{name}%").limit(limit)
  }
  
  
  def to_s
    "#{display_name}"
  end
  
end
