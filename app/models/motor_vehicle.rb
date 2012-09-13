class MotorVehicle < Post
    
  # override
  def topfeedable?
    true
  end

  Categories = Common.new_orderd_hash
  Categories[:new_car] = "new_car"
  Categories[:used_car] = "used_car"
  
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
    
  attr_accessible :price 

end