class Image < Attachable
  attr_accessible :zindex
  
   has_attached_file :avatar, :styles => { :medium => "400x400>", :thumb => "120x120>" },
   :url  => "/system/data/:class/:attachment/:id_partition/:style/:basename.:extension",
   :path => ':rails_root/public/system/data/:class/:attachment/:id_partition/:style/:filename'
   
  def to_s
    super.to_s
  end
  
  after_initialize :set_default
    
  def set_default
    self.thumb_size ||= "120x120>"
    self.medium_size ||= "400x400>"
  end
  
end
