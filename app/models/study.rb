class Study < Post

  Categories = Hash.new
  Categories[:for_study_overseas] = "for_study_overseas"
  Categories[:for_language] = "for_language"
  
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