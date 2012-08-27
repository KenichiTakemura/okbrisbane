class CreateAccommodations < CreatePosts

  def change
    create_base_table(:accommodations)
    add_column :accommodations, :price, :string
    add_column :accommodations, :room_type, :string
  end
end
