class CreateMypages < ActiveRecord::Migration
  def change
    create_table :mypages do |t|
      t.references :user
      t.boolean :is_public, :default => false
      t.string :public_url, :null => true
      t.integer :blocked, :default => 0
      t.integer :num_of_post, :default => 0
      t.boolean :is_blacklist, :default => false
      t.boolean :nologin, :default => false
      t.timestamps
    end
  end
end
