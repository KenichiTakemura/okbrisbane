class CreateBanners < ActiveRecord::Migration
  def change
    create_table(:banners) do |t|
      t.references :page
      t.references :section
      t.integer :position_id
      t.string :display_name
      t.integer :div_width
      t.integer :div_height
      t.integer :img_width
      t.integer :img_height
      t.string :style
      t.string :effect
      t.integer :effect_speed
      t.boolean :enabled, :default => true
      t.timestamps
    end
  end
end
