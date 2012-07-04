class CreateAttachments < CreateAttachables
  def change
    create_base_table(:attachments)
  end
end