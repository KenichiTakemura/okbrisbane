class CreatePosts < ActiveRecord::Migration
#  def change
    # create_table :posts do |t|
      # t.string :type
      # t.string :locale, :null => false
      # t.references :posted_by, :polymorphic => true
      # t.string :category, :null => false
      # t.string :subject, :null => false
      # t.datetime :postedOn, :null => false
      # t.integer  :valid_days, :default => 0
      # t.datetime :valid_until, :null => false
      # t.integer :views, :default => 0
      # t.integer :likes, :default => 0
      # t.integer :dislikes, :default => 0
      # t.integer :rank, :default => 0
      # t.boolean :abuse, :default => false
      # t.boolean :is_deleted, :default => false
    # end
  # end
  
  def create_base_table(table)
    create_table table do |t|
      # :type must be included in case of STI
#      t.string :type
      t.string :locale, :null => false
      t.references :posted_by, :polymorphic => true
      t.string :category, :null => false
      t.string :subject, :null => false
      t.datetime :postedOn, :null => false
      t.integer  :valid_days, :default => 0
      t.datetime :valid_until, :null => false
      t.integer :views, :default => 0
      t.integer :likes, :default => 0
      t.integer :dislikes, :default => 0
      t.integer :rank, :default => 0
      t.boolean :abuse, :default => false
      t.boolean :is_deleted, :default => false
    end    
  end
end
