class RemoveIndexEmailToUsers < ActiveRecord::Migration
  def change
    remove_index :users, :email
    add_index :users, [:provider, :uid]
  end
end
