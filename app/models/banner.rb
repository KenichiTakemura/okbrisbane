class Banner < ActiveRecord::Base
  attr_accessible :page_id
  attr_accessible :section_id
  attr_accessible :position_id
  attr_accessible :div_width
  attr_accessible :div_height
  attr_accessible :img_width
  attr_accessible :img_height
  attr_accessible :style
  attr_accessible :effect
  attr_accessible :effect_speed
  attr_accessible :is_disabled
  attr_accessible :is_random
  
  attr_accessible :attached
  attr_accessible :display_name
  
  # many-to-many
  has_many :banner_image
  has_many :client_image, :through => :banner_image
  
  belongs_to :page
  belongs_to :section
  
  # TODO Is this all?
  E_SLIDE = "slide_auto"
  E_SLIDE_W_CAPTION = "slide_w_caption"
  E_FIX = "fix"
  
  validates_inclusion_of :effect, :in => [E_SLIDE,E_SLIDE_W_CAPTION,E_FIX], :message => I18n.t('must_be_selected')
  validates_numericality_of :effect_speed, :greater_than => 0, :message => I18n.t('must_be_numbers')
  
  def effect_list
    [[I18n.t("#{E_SLIDE}"),E_SLIDE],[I18n.t("#{E_SLIDE_W_CAPTION}"),E_SLIDE_W_CAPTION],[I18n.t("#{E_FIX}"),E_FIX]]
  end
  
  after_initialize :set_default
  
  def set_default
    self.effect = E_FIX
    self.effect_speed = 5
  end
  
  def name
    self.display_name ||= _name
  end

  # pagination
  default_scope :order => 'id ASC'
  paginates_per 10
  
  def to_s
    "p_id: #{page_id} s_id: #{section_id} a_id: #{position_id} d_w: #{div_width} d_h: #{div_height} i_w: #{img_width} i_h: #{img_height} s: #{style} ef: #{effect} es: #{:effect_speed} dn: #{is_disabled} ran: #{is_random} i: #{client_image}"
  end
  
  def _name
    "#{I18n.t(page.name)} >> #{I18n.t(section.name)}\##{position_id}"
  end
  
  def img_resolution
     "#{img_width}x#{img_height}"
  end
  
  def div_resolution
     "#{div_width}x#{div_height}"
  end
  
end