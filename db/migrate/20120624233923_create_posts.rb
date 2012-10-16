class CreatePosts < ActiveRecord::Migration

  def create_base_table(table)
    create_table(table,:options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :locale, :null => false
      t.references :posted_by, :polymorphic => true
      t.references :post_updated_by, :polymorphic => true
      t.string :category, :null => false
      t.string :subject, :null => false
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
      t.boolean :comment_email, :default => false
      t.boolean :has_image, :default => false
      t.boolean :has_attachment, :default => false
      t.timestamps
    end
    add_index table, :z_index
  end
end
