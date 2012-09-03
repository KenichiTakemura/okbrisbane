class CreateDailyHits < ActiveRecord::Migration
  def change
    create_table :daily_hits do |t|
      t.datetime :day, :null => false
      t.integer :hit, :null => false, :default => 0
      t.integer :user_hit, :null => false, :default => 0
      t.timestamps
    end
  end
end
