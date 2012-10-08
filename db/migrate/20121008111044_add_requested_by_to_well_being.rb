class AddRequestedByToWellBeing < ActiveRecord::Migration
  def change
    add_column :well_beings, :requested_by, :string
  end
end
