class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_name
      t.integer :role_value
      t.references :rolable, :polymorphic => true
      t.timestamps
    end
  end
end
