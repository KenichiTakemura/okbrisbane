class Image < Attachable
  attr_accessible :write_at, :something, :link_to_url, :source_url
  has_one :hot_feed_list, :as => :hot_feeded_to, :dependent => :destroy

  has_attached_file :avatar,
  :styles => lambda { |a|
   if a.instance.thumbnailable?
     { :medium => "460x320>", :thumb => "120x120>" }
   else 
     { }
   end
   },
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
   
  def to_s
    super.to_s + " write_at: #{write_at} something: #{something} link_to_url: #{link_to_url} source_url: #{source_url}"
  end

  # https://github.com/thoughtbot/paperclip
  validates_attachment_size :avatar, :less_than => Okvalue::MAX_POST_IMAGE_SIZE
  validates :avatar_content_type, :thumbnailable => true
  validates_presence_of :write_at, :message => I18n.t('must_be_filled')
  validates_presence_of :original_size, :message => I18n.t('failed_to_create')
  validates_format_of :link_to_url, :with => URI::regexp(%w(http https)), :message => I18n.t("invalid"), :if => Proc.new { |image| !image.link_to_url.empty? }
  validates_format_of :source_url, :with => URI::regexp(%w(http https)), :message => I18n.t("invalid"), :if => Proc.new { |image| !image.source_url.empty? }

  #Paperclip callbacks
  after_post_process :proc_geo
  
  after_initialize :set_default

  def set_default
    self.thumb_size ||= "120x120"
    self.medium_size ||= "460x320"
    self.link_to_url ||= ""
    self.source_url ||= ""
    self.something ||= ""
  end

  def thumb_width
    "120"
  end

  def thumb_height
    "120"
  end
  
  def medium_width
    "460px"
  end
  
  def medium_height
    "320px"
  end
  
  def thumb_image
    return self.avatar.url(:thumb) if self.source_url.empty?
    self.source_url
  end
  
  def medium_image
    return self.avatar.url(:medium) if self.source_url.empty?
    self.source_url
  end
  
  def original_image
    return self.avatar.url(:original) if self.source_url.empty?
    self.source_url
  end
  
  def linkable?
    if !self.link_to_url.nil? && !self.link_to_url.empty?
      return true
    end
    false
  end
  
  def somethingable?
    if !self.something.nil? && !self.something.empty?
      return true
    end
    false
  end
  
  def link
    self.link_to_url
  end
  
  def width
    original_size.split("x")[0]
  end

  def height
    original_size.split("x")[1]
  end

end
