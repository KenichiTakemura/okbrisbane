class CreateAlignments < ActiveRecord::Migration
  def change
    create_table :alignments do |t|
      t.string :name
      t.string :display_name
      t.timestamps
    end
  end
end
