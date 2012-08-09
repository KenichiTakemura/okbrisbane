class Law < Post

  FOR_CRIMINAL_ACTION = "for_criminal_action"
  FOR_CONVEYANCING = "for_conveyancing"
  FOR_BUSINESS_BUY_AND_SELL = "for_business_buysing_and_selling"
  FOR_TRAFFIC_ACCIDENT = "for_traffic_accident"
  FOR_ACCIDENT = "for_accident"

  Categories = Hash.new
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