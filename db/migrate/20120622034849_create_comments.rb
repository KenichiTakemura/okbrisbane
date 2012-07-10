class CreateComments < ActiveRecord::Migration
  def change
    create_table(:comments, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.boolean :is_deleted, :default => false
      t.string :locale
      t.text :body
      t.boolean :abuse, :default => false
      t.references :commented, :polymorphic => true
      t.references :commented_by, :polymorphic => true
      t.timestamps
    end
  end
end