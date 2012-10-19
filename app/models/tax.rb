class Tax < Post

  # override
  def topfeedable?
    true
  end
  
  Categories = Common.new_orderd_hash
  Categories[:for_business] = "for_business"
  Categories[:for_tax_return] = "for_tax_return"
  Categories[:for_personal] = "for_personal"

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
