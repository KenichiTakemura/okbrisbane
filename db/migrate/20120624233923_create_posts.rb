class CreatePosts < ActiveRecord::Migration

  
  def create_base_table(table)
    create_table table do |t|
      t.string :locale, :null => false
      t.references :posted_by, :polymorphic => true
      t.references :post_updated_by, :polymorphic => true
      t.string :category, :null => false
      t.string :subject, :null => false
      t.integer  :valid_days, :default => 0
      t.datetime :valid_until, :null => false
      t.integer :views, :default => 0
      t.integer :likes, :default => 0
      t.integer :dislikes, :default => 0
      t.integer :rank, :default => 0
      t.integer :abuse, :default => 0
      t.string :status, :null => false
      t.integer :z_index, :default => 0
      t.integer :write_at
      t.integer :mode
      t.timestamps
    end    
  end
end
