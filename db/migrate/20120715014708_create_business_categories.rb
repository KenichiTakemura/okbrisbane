class CreateBusinessCategories < ActiveRecord::Migration
  def change
    create_table(:business_categories, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8') do |t|
      t.string :name
      t.string :seach_keyword
      t.timestamps
    end
  end
end
