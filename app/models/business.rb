class Business < Post

  after_initialize :set_category
  
  def set_category
    Categories[:for_sale] = "for_sale"
    Categories[:for_auction] = "for_auction"
  end
  
  # attr_accessible
  attr_accessible :price 
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_numericality_of :price, :only_integer => false, :greater_than => 0, :message => I18n.t('must_be_numbers')

end