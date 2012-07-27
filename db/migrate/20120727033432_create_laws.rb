class CreateLaws < CreatePosts
  def change
    create_base_table(:laws)
  end
end
