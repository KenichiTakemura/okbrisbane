class CreateJobs < CreatePosts

  def change
    create_base_table(:jobs)
  end
  
end
