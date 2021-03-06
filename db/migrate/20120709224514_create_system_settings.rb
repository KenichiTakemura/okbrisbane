class CreateSystemSettings < ActiveRecord::Migration
  def change
    create_table :system_settings do |t|
      t.integer :post_expiry_length
      t.boolean :socialable, :default => false
      t.string :issue_report_to
      t.string :admin_email
      t.string :contact_email
      t.boolean :top_page_ajax, :default => false
      t.timestamps
    end
  end
end
