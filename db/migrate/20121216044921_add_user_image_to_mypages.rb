class AddUserImageToMypages < ActiveRecord::Migration
  def change
    add_column :mypages, :user_image, :string
  end
end
