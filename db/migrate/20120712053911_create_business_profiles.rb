class CreateBusinessProfiles < ActiveRecord::Migration
  def change
    create_table(:business_profiles, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :head
      t.text :body, :limit => Okvalue::DB_BUSINESS_PROFILE_CONTENT_LENGTH
      t.references :business_client, :polymorphic => true
      t.timestamps
    end
  end
end
