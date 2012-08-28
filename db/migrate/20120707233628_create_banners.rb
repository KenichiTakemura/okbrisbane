class CreateBanners < ActiveRecord::Migration
  def change
    create_table(:banners, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
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
      # true random false in order
      t.boolean :is_random, :default => false
      # true disabled false enabled
      t.boolean :is_disabled, :default => false
      t.timestamps
    end
  end
end
