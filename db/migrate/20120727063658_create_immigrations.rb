class CreateImmigrations < CreatePosts
  def change
    create_base_table(:immigrations)
  end
end
