class BusinessProfile < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :business_client, :polymorphic => true
  validates_presence_of :body
  validates_length_of :body, :maximum => Okvalue::MAX_BUSINESS_PROFILE_CONTENT_LENGTH
  
  def to_s
    "id: #{id}"
  end
  
end
