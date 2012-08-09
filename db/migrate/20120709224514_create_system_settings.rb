class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.integer :post_expiry_length
      t.timestamps
    end
  end
end
