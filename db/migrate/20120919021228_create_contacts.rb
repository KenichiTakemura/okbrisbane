class CreateContacts < ActiveRecord::Migration
  def change
    create_table(:contacts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.references :contacted_by, :polymorphic => true
      t.integer :contact_type
      t.text :body, :limit => Okvalue::DB_POST_COMMENT_LENGTH
      t.string :user_name
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
