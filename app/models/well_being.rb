class WellBeing < ActiveRecord::Base
  
  Categories = Hash.new
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
  
end
