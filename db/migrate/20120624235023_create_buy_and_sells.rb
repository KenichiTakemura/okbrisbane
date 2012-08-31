class CreateBuyAndSells < CreatePosts

  def change
    create_base_table(:buy_and_sells)
    add_column :buy_and_sells, :price, :string
    add_column :buy_and_sells, :item, :integer
  end
  
end
