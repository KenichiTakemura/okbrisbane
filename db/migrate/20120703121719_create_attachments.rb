class CreateAttachments < CreateAttachables
  def change
    create_base_table(:attachments)
    add_column :attachments, :write_at, :integer
  end
end