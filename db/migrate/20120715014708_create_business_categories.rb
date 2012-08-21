class CreateBusinessCategories < ActiveRecord::Migration
  def change
    create_table(:business_categories, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :en_name
      t.string :display_name
      t.string :search_keyword
      t.timestamps
    end
  end
end
