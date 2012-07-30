class CreateClientImages < CreateAttachables
  def change
    create_base_table(:client_images)
    add_column :client_images, :clicked, :integer, :default => 0
    # Although there is updated_at field this is used for particular purpose to get counter
    add_column :client_images, :last_clicked, :timestamp, :null => true
    # if not set link to business profile
    add_column :client_images, :original_size, :string
    add_column :client_images, :link_to_url, :string
    add_column :client_images, :business_client_id, :integer, :references => "business_client"
  end
end