class AddBannerClickableToSystemSettings < ActiveRecord::Migration
  def change
    add_column :system_settings, :banner_clickable, :boolean, :default => true
  end
end
