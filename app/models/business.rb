class Business < Post

  # override
  def topfeedable?
    true
  end

  Categories = Common.new_orderd_hash
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
  attr_accessible :price
  attr_accessible :address


end