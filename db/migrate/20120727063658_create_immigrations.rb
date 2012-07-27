class CreateImmigrations < ActiveRecord::Migration
  def change
    create_table :immigrations do |t|

      t.timestamps
    end
  end
end
