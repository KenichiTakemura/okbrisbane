class Estate < Post
  
  # override
  def topfeedable?
    true
  end
  
  Categories = Hash.new
  Categories[:for_rent] = "for_rent"
  Categories[:for_sale] = "for_sale"
  Categories[:for_auction] = "for_auction"
  Categories[:sold] = "sold"  
  
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
  attr_accessible :price, :bed, :bath, :garage, :address
  validates_presence_of :price

end
