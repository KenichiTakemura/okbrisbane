class CreateAttachables < ActiveRecord::Migration
  def create_base_table(table)
    create_table(table, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.boolean :is_deleted
      t.string :filename, :length => 1024
      t.string :content_type
      t.integer :size
      t.datetime :postedOn
      t.references :attached_by, :polymorphic => true
      t.references :attached, :polymorphic => true
      t.timestamps
    end
  end
end
