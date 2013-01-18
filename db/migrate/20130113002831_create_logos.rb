class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.has_attached_file :avatar
      t.string :original_size
      t.references :attached_by, :polymorphic => true
      t.references :attached, :polymorphic => true
      t.timestamps
    end
  end
end