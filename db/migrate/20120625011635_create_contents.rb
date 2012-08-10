class CreateContents < ActiveRecord::Migration
  def change
    create_table(:contents, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.text  :body, :limit => Okvalue::DB_POST_CONTENT_LENGTH
      t.references :contented, :polymorphic => true
      t.timestamps
    end
  end
end
