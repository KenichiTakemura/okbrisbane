class CreateMemberManagements < ActiveRecord::Migration
  def change
    create_table :member_managements do |t|

      t.timestamps
    end
  end
end
