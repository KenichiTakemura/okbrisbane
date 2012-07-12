class SystemSetting < ActiveRecord::Base
  attr_accessible :image_max_size_in_kb
  attr_accessible :attach_storage_path, :null => true
end
