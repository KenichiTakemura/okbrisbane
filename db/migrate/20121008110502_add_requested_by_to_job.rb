class AddRequestedByToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :requested_by, :string
  end
end
