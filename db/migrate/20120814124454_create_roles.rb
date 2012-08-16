class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_name
      t.integer :role_value
      t.references :user
      t.timestamps
    end
  end
end
