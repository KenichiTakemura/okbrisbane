class AddBannerAjaxableToSystemSettings < ActiveRecord::Migration
  def change
    add_column :system_settings, :banner_ajaxable, :boolean, :default => true
  end
end
