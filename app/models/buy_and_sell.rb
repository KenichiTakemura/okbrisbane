class BuyAndSell < Post

  # override
  def topfeedable?
    true
  end

  Categories = Common.new_orderd_hash
  Categories[:buy] = "buying"
  Categories[:sell] = "selling"
  
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

end
