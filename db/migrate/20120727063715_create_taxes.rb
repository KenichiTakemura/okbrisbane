class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|

      t.timestamps
    end
  end
end
