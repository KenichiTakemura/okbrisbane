class AddRequestedByToBuyAndSell < ActiveRecord::Migration
  def change
    add_column :buy_and_sells, :requested_by, :string
  end
end
