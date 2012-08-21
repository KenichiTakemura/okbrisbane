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
  default_scope :order => 'created_at DESC'
  paginates_per 10
  
  def to_s
    "#{display_name}"
  end
  
end
