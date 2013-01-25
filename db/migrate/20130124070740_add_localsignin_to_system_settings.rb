class AddLocalsigninToSystemSettings < ActiveRecord::Migration
  def change
    add_column :system_settings, :local_signin, :boolean, :default => true
    add_column :system_settings, :facebook_signin, :boolean, :default => true
    add_column :system_settings, :google_signin, :boolean, :default => true
    add_column :system_settings, :naver_signin, :boolean, :default => false
    add_column :system_settings, :twitter_signin, :boolean, :default => false
  end
end
