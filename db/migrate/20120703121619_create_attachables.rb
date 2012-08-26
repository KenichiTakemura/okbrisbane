class CreateAttachables < ActiveRecord::Migration
  def create_base_table(table)
    create_table(table, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.boolean :is_deleted, :default => false
      t.has_attached_file :avatar
      t.string :medium_size
      t.string :thumb_size
      t.string :original_size
      t.references :attached_by, :polymorphic => true
      t.references :attached, :polymorphic => true
      t.timestamps
    end
  end
end
