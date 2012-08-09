class CreateWellBeings < CreatePosts

  def change
    create_base_table(:well_beings)
  end
  
end

