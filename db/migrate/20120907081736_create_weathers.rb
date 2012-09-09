class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.datetime :issuedOn
      t.datetime :dateOn
      t.string :location
      t.integer :country
      t.string :forecast
      t.integer :min
      t.integer :max
      t.string :warning
      t.timestamps
    end
  end
end
