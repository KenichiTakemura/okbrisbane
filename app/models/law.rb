class Law < Post

  # override
  def topfeedable?
    true
  end
  
  Categories = Common.new_orderd_hash
  Categories[:for_criminal_action] = "for_criminal_action"
  Categories[:for_conveyancing] = "for_conveyancing"
  Categories[:for_business_buysing_and_selling] = "for_business_buysing_and_selling"
  Categories[:for_traffic_accident] = "for_traffic_accident"
  Categories[:for_accident] = "for_accident"
  
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