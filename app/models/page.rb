class Page < ActiveRecord::Base
  attr_accessible :name
  
  has_many :banner, :dependent => :destroy
  
  def name_t
    I18n.t(name)
  end
  
  def to_s
    "id: #{id} name: #{name}"
  end
end
