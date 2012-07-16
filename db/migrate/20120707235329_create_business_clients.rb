class CreateBusinessClients < ActiveRecord::Migration
  def change
    create_table(:business_clients, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :business_name, :null => false
      t.string :business_abn
      t.string :business_address
      t.string :business_url
      t.string :business_phone
      t.string :business_fax
      t.string :business_email
      t.string :contact_name
      t.string :search_keyword
      t.references :business_category
      t.timestamps
    end
  end
end
