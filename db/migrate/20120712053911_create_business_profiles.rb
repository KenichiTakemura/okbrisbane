class CreateBusinessProfiles < ActiveRecord::Migration
  def change
    create_table(:business_profiles, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.text :body
      t.references :business_client, :polymorphic => true
      t.timestamps
    end
  end
end
