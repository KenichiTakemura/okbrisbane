class Alignment < ActiveRecord::Base
  attr_accessible :name, :display_name

  has_many :banner, :dependent => :destroy

end
