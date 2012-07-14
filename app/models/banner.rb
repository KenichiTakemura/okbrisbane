class Banner < ActiveRecord::Base
  attr_accessible :page_id, :section_id, :alignment_id, :width, :height, :style, :attached
  
  has_many :client_image, :as => :attached, :class_name => 'ClientImage'
  
  belongs_to :page
  belongs_to :section
  belongs_to :alignment

  # pagination
  default_scope :order => 'created_at DESC'
  paginates_per 10
  
  def to_s
    "page_id: #{page_id} section_id: #{section_id} alignment_id: #{alignment_id}"
  end
  
  def name
    page.name + " >> " + section.name + " >> " + alignment.name
  end
  
  def resolution
     width.to_s << "x" << height.to_s
  end
  
end