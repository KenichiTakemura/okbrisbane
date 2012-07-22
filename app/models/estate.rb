class Estate  < Post

  FOR_RENT = "for_rent"
  FOR_SALE = "for_sale"
  FOR_AUCTION = "for_auction"
  
  # attr_accessible
  attr_accessible :price 
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_numericality_of :price, :only_integer => false, :greater_than => 0, :message => I18n.t('must_be_numbers')
  validates_inclusion_of :category, :in => [FOR_RENT,FOR_SALE,FOR_AUCTION], :message => I18n.t('must_be_selected')

end
