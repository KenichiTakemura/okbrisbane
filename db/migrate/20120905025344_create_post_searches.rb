class CreatePostSearches < ActiveRecord::Migration
  def change
    create_table :post_searches do |t|
      t.string :okpage
      t.string :category
      t.string :keyword
      t.string :price
      t.boolean :image
      t.boolean :attachment
      t.string :time_by
      t.references :searchable, :polymorphic => true
      t.timestamps
    end
  end
end
