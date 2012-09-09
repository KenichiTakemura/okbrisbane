class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.datetime :issuedOn
      t.datetime :dateOn
      t.integer :currency_from
      t.integer :currency_to
      t.integer :buy_or_sell
      t.float :rate_a
      t.float :rate_b
      t.float :rate_c
      t.timestamps
    end
  end
end
