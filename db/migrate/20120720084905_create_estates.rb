class CreateEstates < CreatePosts

  def change
    create_base_table(:estates)
    add_column :estates, :price, :float
    add_column :estates, :address, :string
    add_column :estates, :is_sold, :boolean, :default => false
    add_column :estates, :bed, :integer, :default => 0
    add_column :estates, :bath, :integer, :default => 0
    add_column :estates, :garage, :integer, :default => 0
  end
  
end
