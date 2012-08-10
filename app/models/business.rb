class Business < Post

  Categories = Hash.new
  Categories[:for_rent] = "for_rent"
  Categories[:for_sale] = "for_sale"
  Categories[:for_auction] = "for_auction"
  
  def category_list()
    list = Array.new
    Categories.each do |key,value|
      list.push([I18n.t(value),value])
    end
    list
  end
  
  def getCategory(key)
    Categories[key]
  end
  
  
  # attr_accessible
  attr_accessible :price, :address
  validates_presence_of :price, :message => I18n.t('must_be_filled')
  validates_numericality_of :price, :only_integer => false, :greater_than => 0, :message => I18n.t('must_be_numbers')

end