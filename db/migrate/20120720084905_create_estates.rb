class CreateEstates < CreatePosts

  def change
    create_base_table(:estates)
    add_column :estates, :price, :float
    add_column :estates, :is_sold, :boolean, :default => false
  end
  
end
