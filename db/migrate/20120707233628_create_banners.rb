class CreateBanners < ActiveRecord::Migration
  def change
    create_table(:banners) do |t|
      t.references :page
      t.references :section
      t.references :position
      t.string :display_name
      t.integer :width
      t.integer :height
      t.string :style
      t.timestamps
    end
  end
end
