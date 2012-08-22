class CreateIssues < CreatePosts
  def change
    create_base_table(:issues)
  end
end
