class Banner < ActiveRecord::Base
  attr_accessible :page_id
  attr_accessible :section_id
  attr_accessible :position_id
  attr_accessible :width
  attr_accessible :height
  attr_accessible :style
  attr_accessible :attached
  attr_accessible :display_name
  
  has_many :client_image, :as => :attached, :class_name => 'ClientImage'
  
  belongs_to :page
  belongs_to :section
  
  def name
    self.display_name ||= _name
  end

  # pagination
  default_scope :order => 'id ASC'
  paginates_per 10
  
  def to_s
    "p_id: #{page_id} s_id: #{section_id} a_id: #{position_id} w: #{width} h: #{height} s: #{style} i: #{client_image}"
  end
  
  def _name
    "#{I18n.t(page.name)} >> #{I18n.t(section.name)}\##{position_id}"
  end
  
  def resolution
     "#{width}x#{height}"
  end
  
end