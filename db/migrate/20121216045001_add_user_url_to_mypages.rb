class AddUserUrlToMypages < ActiveRecord::Migration
  def change
    add_column :mypages, :user_url, :string
  end
end
