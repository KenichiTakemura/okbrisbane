class Home < ActiveRecord::Base
  has_many :business_profile_image, :as => :attached, :dependent => :destroy, :class_name => 'BusinessProfileImage'
end
