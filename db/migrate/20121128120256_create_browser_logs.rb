class CreateBrowserLogs < ActiveRecord::Migration
  def change
    create_table :browser_logs do |t|
      t.integer :day, :null => false
      t.integer :pc_other, :default => 0
      t.integer :pc_sf, :default => 0
      t.integer :pc_ch, :default => 0
      t.integer :pc_ff, :default => 0
      t.integer :pc_op, :default => 0
      t.integer :pc_ie, :default => 0
      t.integer :mo_other, :default => 0
      t.integer :mo_sf, :default => 0
      t.integer :mo_ch, :default => 0
      t.integer :mo_ff, :default => 0
      t.integer :mo_op, :default => 0
      t.integer :mo_ie, :default => 0
      t.timestamps
    end
  end
end
