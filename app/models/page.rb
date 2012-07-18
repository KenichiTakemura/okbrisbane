class Page < ActiveRecord::Base
  attr_accessible :name, :display_name
  
  has_many :banner, :dependent => :destroy
  
  def name_t
    I18n.t(name)
  end
end
