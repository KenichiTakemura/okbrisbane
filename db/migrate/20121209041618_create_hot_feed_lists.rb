class CreateHotFeedLists < ActiveRecord::Migration
  def change
    create_table :hot_feed_lists do |t|
      t.references :hot_feeded_to, :polymorphic => true
      t.integer :hot_key
      t.integer :hot_value
      t.timestamps
    end
  end
end
