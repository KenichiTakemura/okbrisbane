class CreatePostSearches < ActiveRecord::Migration
  def change
    create_table :post_searches do |t|

      t.timestamps
    end
  end
end
