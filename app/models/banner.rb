class Banner < ActiveRecord::Base
  attr_accessible :page_id, :section_id, :position_id, :width, :height, :style, :attached
  attr_accessible :display_name
  
  has_many :client_image, :as => :attached, :class_name => 'ClientImage'
  
  belongs_to :page
  belongs_to :section
  belongs_to :position
  
  before_save :set_display_name
  
  def set_display_name
    self.display_name ||= name
  end

  # pagination
  default_scope :order => 'id ASC'
  paginates_per 10
  
  def to_s
    "p_id: #{page_id} s_id: #{section_id} a_id: #{position_id} w: #{width} h: #{height} s: #{style} i: #{client_image}"
  end
  
  def name
    I18n.t(page.name) + " >> " + I18n.t(section.name) + " >> " + I18n.t(position.name)
  end
  
  def resolution
     width.to_s << "x" << height.to_s
  end
  
end