class CreateImages < CreateAttachables
  def change
    create_base_table(:images)
    add_column :images, :zindex, :integer
  end
end