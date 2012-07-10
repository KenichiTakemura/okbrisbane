class CreateTopFeedLists < ActiveRecord::Migration
  def change
    create_table :top_feed_lists do |t|
      t.references :feeded_to, :polymorphic => true
      t.timestamps
    end
  end
end