class CreateStudies < CreatePosts
  def change
    create_base_table(:studies)
  end
end
