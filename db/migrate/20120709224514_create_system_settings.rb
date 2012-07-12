class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.string :image_thumbnail_size
      t.string :image_max_size_in_kb
      t.string :attach_acceptable_extention
      t.string :attach_storage_path
      t.string :business_profile_picture_size
      t.timestamps
    end
  end
end
