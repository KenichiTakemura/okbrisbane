class CreateBannerImages < ActiveRecord::Migration
  def change
    create_table :banner_images do |t|
      t.references :banner
      t.references :client_image
      t.timestamps
    end
  end
end
