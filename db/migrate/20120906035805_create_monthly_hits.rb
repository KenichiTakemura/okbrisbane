class CreateMonthlyHits < ActiveRecord::Migration
  def change
    create_table :monthly_hits do |t|
      t.datetime :month, :null => false
      t.integer :hit, :null => false, :default => 0
      t.integer :user_hit, :null => false, :default => 0
      t.timestamps
    end
  end
end
