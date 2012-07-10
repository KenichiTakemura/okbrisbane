class CreateBanners < ActiveRecord::Migration
  def change
    create_table(:banners) do |t|
      t.references :page
      t.references :section
      t.references :alignment
      t.integer :width
      t.integer :height
      t.string :style
      t.references :attached, :polymorphic => true
    end
  end
end
