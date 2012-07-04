class CreateContents < ActiveRecord::Migration
  def change
    create_table(:contents, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.text  :body
      t.references :contented, :polymorphic => true
      t.timestamps
    end
  end
end
