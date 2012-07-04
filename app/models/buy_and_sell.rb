class BuyAndSell < Post

  BUY = "buy"
  SELL = "sell"
  
  # attr_accessible
  attr_accessible :price 

  validates_inclusion_of :category, :in => [BUY,SELL]

end
