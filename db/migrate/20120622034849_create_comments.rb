class CreateComments < ActiveRecord::Migration
  def change
    create_table(:comments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.boolean :is_deleted, :default => false
      t.string :locale
      t.text :body, :limit => Okvalue::DB_POST_COMMENT_LENGTH
      t.integer :abuse, :default => 0
      t.integer :likes, :default => 0
      t.integer :dislikes, :default => 0
      t.references :commented, :polymorphic => true
      t.references :commented_by, :polymorphic => true
      t.timestamps
    end
  end
end