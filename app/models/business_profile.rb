class BusinessProfile < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :business_client, :polymorphic => true
  
  def to_s
    "id: #{id}"
  end
  
end
