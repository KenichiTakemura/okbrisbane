class AddNumberToComments < ActiveRecord::Migration
  def change
    add_column :comments, :number, :integer
  end
end
