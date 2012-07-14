class CreateBusinessProfileImages < CreateAttachables
  def change
  create_base_table(:business_profile_images)
  add_column :business_profile_images, :business_client_id, :integer, :references => "business_client"
  end
end
