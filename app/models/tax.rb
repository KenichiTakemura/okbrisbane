class Tax < Post

  # override
  def topfeedable?
    true
  end
  
  Categories = Hash.new
  Categories[:for_business] = "for_business"
  Categories[:for_tax_return] = "for_tax_return"
  
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
  
end
