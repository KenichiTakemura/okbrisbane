class CreateAdminNotices < ActiveRecord::Migration
  def change
    create_table(:admin_notices,:options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.references :posted_by, :polymorphic => true
      t.string :subject, :null => false
      t.string :status, :null => false
      t.timestamps
    end
  end
end
