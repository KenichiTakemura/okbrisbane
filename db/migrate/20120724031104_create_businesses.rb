class CreateBusinesses < CreatePosts

  def change
    create_base_table(:businesses)
    add_column :businesses, :price, :string
    add_column :businesses, :address, :string
  end

end
