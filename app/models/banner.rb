class Banner < ActiveRecord::Base
  attr_accessible :page_id, :section_id, :alignment_id, :width, :height, :style, :attached
  
  has_many :client_image, :as => :attached, :class_name => 'ClientImage'
  
  belongs_to :page
  belongs_to :section
  belongs_to :alignment

end