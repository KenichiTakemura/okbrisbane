class CreateIssues < CreatePosts
  def change
    create_base_table(:issues)
    add_column :issues, :version, :string
  end
end
