class CreateQuickLinks < ActiveRecord::Migration
  def change
    create_table :quick_links do |t|
      t.string :name
      t.string :link_to
      t.integer :sort_key
      t.timestamps
    end
  end
end
