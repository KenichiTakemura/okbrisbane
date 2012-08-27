class CreateMotorVehicles < CreatePosts
  
  def change
    create_base_table(:motor_vehicles)
    add_column :motor_vehicles, :price, :string
    add_column :motor_vehicles, :is_sold, :boolean, :default => false
  end
  
end
