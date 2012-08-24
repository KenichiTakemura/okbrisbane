class CreateBusinessProfileImages < CreateAttachables
  def change
    create_base_table(:business_profile_images)
    add_column :business_profile_images, :original_size, :string
    add_column :business_profile_images, :is_main, :boolean, :default => false
  end
end
