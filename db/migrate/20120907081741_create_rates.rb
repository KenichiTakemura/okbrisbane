class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.datetime :issuedOn
      t.datetime :dateOn
      t.string :currency_from
      t.string :currency_to
      t.float :rate_a
      t.float :rate_b
      t.float :rate_c
      t.timestamps
    end
  end
end
