class WellBeing < Post
  
  # override
  def topfeedable?
    true
  end
  
  Categories = Common.new_orderd_hash
  Categories[:event] = "event"
  Categories[:giving_info] = "giving_info"
  Categories[:asking_info] = "asking_info"
  
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
  
  attr_accessible :requested_by
end
