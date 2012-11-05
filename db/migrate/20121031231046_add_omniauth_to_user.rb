class AddOmniauthToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :agreed_on, :datetime
  end
end
