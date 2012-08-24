class CreateImages < CreateAttachables
  def change
    create_base_table(:images)
    add_column :images, :original_size, :string
    add_column :images, :write_at, :integer
    add_column :images, :something, :string, :limit => 255
  end
end