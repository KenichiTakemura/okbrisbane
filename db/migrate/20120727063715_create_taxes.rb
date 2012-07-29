class CreateTaxes < CreatePosts
  def change
   create_base_table(:taxes)
  end
end
