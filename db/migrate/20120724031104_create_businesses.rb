class CreateBusinesses < CreatePosts

  def change
    create_base_table(:businesses)
    add_column :businesses, :price, :float
    add_column :businesses, :is_sold, :boolean, :default => false
  end

end
