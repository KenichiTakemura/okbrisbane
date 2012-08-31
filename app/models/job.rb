class Job < Post

  # override
  def topfeedable?
    true
  end
  
  Categories = Hash.new
  Categories[:seek] = "seeking"
  Categories[:hire] = "hiring"
  
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
